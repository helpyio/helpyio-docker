FROM ruby:2.2.1

ENV RAILS_VERSION 4.2.6
ENV RAILS_ENV production
ENV HELPY_HOME /helpy
ENV HELPY_USER helpyuser

RUN apt-get update \
  && apt-get install -y nodejs postgresql-client --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && useradd --no-create-home $HELPY_USER \
  && mkdir -p $HELPY_HOME \
  && chown -R $HELPY_USER:$HELPY_USER $HELPY_HOME /usr/local/lib/ruby /usr/local/bundle

WORKDIR $HELPY_HOME

USER $HELPY_USER

RUN git clone --depth=1 https://github.com/helpyio/helpy.git .

RUN bundle install

RUN touch /helpy/log/production.log && chmod 0664 /helpy/log/production.log

# Due to a weird issue with one of the gems, execute this permissions change:
RUN chmod +r /usr/local/bundle/gems/griddler-mandrill-1.1.3/lib/griddler/mandrill/adapter.rb

COPY database.yml $HELPY_HOME/config/database.yml
COPY run.sh $HELPY_HOME/run.sh

CMD ["./run.sh"]
