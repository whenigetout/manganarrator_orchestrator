# manganarrator_orchestrator: project context

Source review: 2026-10-21. Baseline commit: `65afd5f7b2d6648003e55036d69ab25f095e332a`.
For later sessions, compare relevant paths against that commit; avoid re-auditing unrelated services.

## Purpose and boundaries

Django filesystem/media API with an OCR folder proxy. Heavy inference/rendering belongs to other services.

MEDIA_ROOT plus inputs/outputs namespaces must agree across services. Keep safe path resolution and versioned audio semantics. MANGANARRATOR_OCR_API defaults to http://localhost:7860; MANGANARRATOR_OCR_TIMEOUT defaults to 3600.

## Code map

orchestrator/settings.py; orchestrator/urls.py; manga_narrator/urls.py; manga_narrator/views.py; manga_narrator/utils.py; manga_narrator/contracts/endpoint_contracts.py

## Setup and checks

In a configured Python environment: `python manage.py check`; `python manage.py test`; `python manage.py migrate`; `python manage.py runserver 9000`. Existing tests.py is only a scaffold; a passing empty suite is not behavior coverage.

## Known details and gaps

requirements.txt is a machine-specific Conda freeze with local file URLs, not a portable installer. settings.py has local-development defaults and a Windows media path. Actual URLs come from urls.py, not the older README endpoint labels.

## Current state / next work

This note was grounded in source inspection at the baseline above. Runtime verification for this service is recorded below only when actually executed. Documentation-only edits do not establish that GPU inference, external APIs, or the complete distributed manga pipeline work in this environment.

For story production, first inspect [Story Studio in the video service](https://github.com/whenigetout/manganarrator_video/blob/main/docs/STORY_STUDIO.md). The first slice uses imported segment audio; OCR and Paddle are unchanged. Native story TTS is a later adapter, not an image-shaped workaround.

## Related repositories

[Central ecosystem map](https://github.com/whenigetout/manganarrator/blob/main/docs/ECOSYSTEM.md) owns service responsibilities and the cross-repo task routing table. Consult it only for work crossing a service boundary.
