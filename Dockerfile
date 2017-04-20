FROM python:latest

ENV HOME /root
WORKDIR $HOME

RUN pip install ipython jupyter

# Erlang

RUN echo "deb http://packages.erlang-solutions.com/debian jessie contrib" >> /etc/apt/sources.list \
    && curl -O http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc \
    && apt-key add erlang_solutions.asc \
    && apt-get update && apt-get install -y --no-install-recommends \
    erlang \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME/ierlang
ADD . $HOME/ierlang
RUN cd kernels && jupyter kernelspec install erlang

EXPOSE 8888

CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip='*'"]
