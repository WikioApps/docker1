
# Official WZML-X tools/runtime base
FROM mysterysd/wzmlx:wzadv

ARG WZML_BRANCH=wzv3

ENV PATH="/wzvenv/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8080

WORKDIR /usr/src/app

# Clone upstream source and install dependencies
RUN set -eux; \
    git clone --depth 1 --single-branch --branch "${WZML_BRANCH}" \
      https://github.com/SilentDemonSD/WZML-X.git /tmp/wzmlx-source; \
    cp -a /tmp/wzmlx-source/. /usr/src/app/; \
    rm -rf /tmp/wzmlx-source; \
    uv pip install --python /wzvenv/bin/python --no-cache-dir -r requirements.txt; \
    mkdir -p /usr/src/app/accounts /usr/src/app/downloads

EXPOSE 8080

# Run directly using hosting environment variables
ENTRYPOINT ["/wzvenv/bin/python", "-m", "bot"]
