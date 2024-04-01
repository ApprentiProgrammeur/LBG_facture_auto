# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM python:3.10-alpine

WORKDIR /PROD_LBG_FACTURE_AUTO

RUN mkdir /PROD_LBG_FACTURE_AUTO/factures
# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install the requirements
COPY requirements.txt /PROD_LBG_FACTURE_AUTO
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

COPY . .

# initialize the database (create DB, tables, populate)
#RUN python init_db.py

EXPOSE 5000/tcp

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "LBG_pdf_generator:app"]