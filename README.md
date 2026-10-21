> Returning to this repo? Start with [AGENTS.md](AGENTS.md) and [project context](docs/PROJECT_CONTEXT.md).

# MangaNarrator Orchestrator

Backend orchestration service for the Manga Narrator system.

This Django-based API layer acts as the filesystem-aware backend that serves
OCR results, TTS outputs, image assets, and versioned media to the frontend.

It does NOT run OCR, TTS, or video generation directly.
It provides structured access and validation for pipeline artifacts.

---

## 🧠 Purpose

The orchestrator:

- Serves manga input images
- Serves OCR JSON artifacts
- Serves versioned TTS audio files
- Saves corrected OCR JSON
- Saves recorded dialogue audio
- Enforces namespace + path safety
- Validates domain models via Pydantic contracts

All heavy ML work (OCR, TTS, video) is executed externally.
The frontend triggers those pipelines separately.

---

## 🏗 Architecture Overview

Frontend
   ↓
Orchestrator API (this repo)
   ↓
External Shared Media Folder
   (e.g. E:\PCC_SHARED\MANGA_NARRATOR_RUNS)

This service is intentionally lightweight and file-centric.

---

## 📁 Media Architecture

The system uses namespace-based media isolation:

- INPUTS namespace
- OUTPUTS namespace

Artifacts live in an external shared folder (configured via `MEDIA_ROOT`).

Example structure:

```
MEDIA_ROOT/
├── inputs/
│   └── test_mangas/
├── outputs/
│   └── <run_id>/
│       └── <image_uuid>/
│           ├── ocrrun.json
│           ├── ocrrun_final.json
│           └── dialogue__<id>/
│               ├── v1.wav
│               └── v2_recorded.wav
```

The backend ensures safe resolution and prevents path traversal.

---

## 🚀 Setup

### 1. Create Conda Environment

```bash
conda create -n manganarrator python=3.11
conda activate manganarrator
```

### 2. Install Requirements
```pip install -r requirements.txt```


### 3. Configure Settings
Set your MEDIA_ROOT to the shared media folder:
```
MEDIA_ROOT = r"E:\PCC_SHARED\MANGA_NARRATOR_RUNS"
```
Ensure MEDIA_NAMESPACE_KEYS is defined properly.

### 4. ▶ Running the Server
```
python manage.py migrate
python manage.py runserver 9000
```

OR simply use the start_backend.bat file (windows)

Default:
```
http://127.0.0.1:9000/
```

### 5. 📡 Core Endpoints
## Directory Listing

```
GET /manga_dir_view
```
Lists folders/files under a namespace.

## Load OCR JSON
```
GET /manga_json_file_view
```
Returns validated OCRRun or VideoPreview JSON.

## Latest TTS Audio
```
GET /latest_tts_audio_view
```
Returns latest versioned .wav file for a dialogue line.

## Serve Manga Image
```
GET /manga_image_view
```
Safely streams image file from disk.

## Save Corrected OCR
```
POST /save_augmented_ocr_json
```
Stores ocrrun_final.json.

## Save Recorded Dialogue Audio
```
POST /save_recorded_audio
```
Saves versioned dialogue audio and converts to WAV.