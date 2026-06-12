#!/usr/bin/env python3
"""Wire a release signingConfig into the Flutter-generated Android Gradle file
and repoint the release buildType from the debug key to it.
Handles Kotlin DSL (build.gradle.kts) and Groovy. Fails loudly on problems.
"""
import glob
import re
import sys

candidates = glob.glob("android/app/build.gradle.kts")
candidates += glob.glob("android/app/build.gradle")
if not candidates:
    raise SystemExit("No android/app/build.gradle[.kts] found")

path = candidates[0]
kts = path.endswith(".kts")
src = open(path, encoding="utf-8").read()
original = src

if kts:
    loader_lines = [
        "import java.util.Properties",
        "import java.io.FileInputStream",
        "",
        "val keystoreProperties = Properties()",
        'val keystorePropertiesFile = rootProject.file("key.properties")',
        "if (keystorePropertiesFile.exists()) {",
        "    keystoreProperties.load(FileInputStream(keystorePropertiesFile))",
        "}",
        "",
        "",
    ]
    sign_lines = [
        "    signingConfigs {",
        '        create("release") {',
        '            keyAlias = keystoreProperties["keyAlias"] as String',
        '            keyPassword = keystoreProperties["keyPassword"] as String',
        '            storeFile = file(keystoreProperties["storeFile"] as String)',
        '            storePassword = keystoreProperties["storePassword"] as String',
        "        }",
        "    }",
        "",
    ]
    debug_ref = 'signingConfig = signingConfigs.getByName("debug")'
    release_ref = 'signingConfig = signingConfigs.getByName("release")'
else:
    loader_lines = [
        "def keystoreProperties = new Properties()",
        'def keystorePropertiesFile = rootProject.file("key.properties")',
        "if (keystorePropertiesFile.exists()) {",
        "    keystorePropertiesFile.withInputStream { keystoreProperties.load(it) }",
        "}",
        "",
        "",
    ]
    sign_lines = [
        "    signingConfigs {",
        "        release {",
        "            keyAlias keystoreProperties['keyAlias']",
        "            keyPassword keystoreProperties['keyPassword']",
        "            storeFile file(keystoreProperties['storeFile'])",
        "            storePassword keystoreProperties['storePassword']",
        "        }",
        "    }",
        "",
    ]
    debug_ref = "signingConfig signingConfigs.debug"
    release_ref = "signingConfig signingConfigs.release"

loader = "\n".join(loader_lines)
sign_block = "\n".join(sign_lines)

if "keystoreProperties" not in src:
    src = loader + src

if "signingConfigs {" not in src:
    src = re.sub(r"(\n[ \t]*buildTypes[ \t]*\{)", "\n" + sign_block + r"\1", src, count=1)

if debug_ref in src:
    src = src.replace(debug_ref, release_ref, 1)
elif release_ref not in src:
    src = re.sub(r"(\n[ \t]*release[ \t]*\{)", r"\1\n            " + release_ref, src, count=1)

if src == original:
    sys.stderr.write("ERROR: gradle file was not modified\n")
    sys.exit(1)

open(path, "w", encoding="utf-8").write(src)
print("----- patched", path, "-----")
print(src)

if release_ref not in src:
    sys.stderr.write("ERROR: release signingConfig not wired\n")
    sys.exit(1)
print("OK: release signingConfig wired")
