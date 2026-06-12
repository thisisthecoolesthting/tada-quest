#!/usr/bin/env python3
"""Inject a release signingConfig into the Flutter-generated Android Gradle file.
Run from app_flutter/. Handles both Groovy (build.gradle) and Kotlin DSL (.kts)."""
import glob
import re

candidates = glob.glob("android/app/build.gradle") + glob.glob(
    "android/app/build.gradle.kts"
)
if not candidates:
    raise SystemExit("No android/app/build.gradle[.kts] found")
path = candidates[0]
kts = path.endswith(".kts")
src = open(path, encoding="utf-8").read()

if kts:
    loader = (
        "import java.util.Properties\n"
        "import java.io.FileInputStream\n\n"
        "val keystoreProperties = Properties()\n"
        'val keystorePropertiesFile = rootProject.file("key.properties")\n'
        "if (keystorePropertiesFile.exists()) "
        "{ keystoreProperties.load(FileInputStream(keystorePropertiesFile)) }\n\n"
    )
    if "key.properties" not in src:
        src = loader + src
    sign = (
        "    signingConfigs {\n"
        '        create("release") {\n'
        '            keyAlias = keystoreProperties["keyAlias"] as String\n'
        '            keyPassword = keystoreProperties["keyPassword"] as String\n'
        '            storeFile = file(keystoreProperties["storeFile"] as String)\n'
        '            storePassword = keystoreProperties["storePassword"] as String\n'
        "        }\n"
        "    }\n"
    )
    src = re.sub(r"(\n\s*buildTypes\s*\{)", "\n" + sign + r"\1", src, count=1)
    src = re.sub(
        r'getByName\("release"\)\s*\{',
        'getByName("release") {\n            '
        'signingConfig = signingConfigs.getByName("release")',
        src,
        count=1,
    )
else:
    loader = (
        "def keystoreProperties = new Properties()\n"
        'def keystorePropertiesFile = rootProject.file("key.properties")\n'
        "if (keystorePropertiesFile.exists()) "
        "{ keystorePropertiesFile.withInputStream { keystoreProperties.load(it) } }\n\n"
    )
    if "key.properties" not in src:
        src = loader + src
    sign = (
        "    signingConfigs {\n"
        "        release {\n"
        "            keyAlias keystoreProperties['keyAlias']\n"
        "            keyPassword keystoreProperties['keyPassword']\n"
        "            storeFile file(keystoreProperties['storeFile'])\n"
        "            storePassword keystoreProperties['storePassword']\n"
        "        }\n"
        "    }\n"
    )
    src = re.sub(r"(\n\s*buildTypes\s*\{)", "\n" + sign + r"\1", src, count=1)
    src = re.sub(
        r"release\s*\{",
        "release {\n            signingConfig signingConfigs.release",
        src,
        count=1,
    )

open(path, "w", encoding="utf-8").write(src)
print(f"----- patched {path} -----")
print(src)
