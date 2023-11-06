FROM michalhosna/adminer

USER root

ARG ADMINER_DESIGN="nette"

WORKDIR /var/adminer
RUN echo "Getting design for Adminer: ${ADMINER_DESIGN}..."
RUN curl -L https://raw.githubusercontent.com/vrana/adminer/master/designs/${ADMINER_DESIGN}/adminer.css -o adminer.css