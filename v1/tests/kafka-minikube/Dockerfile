FROM wurstmeister/kafka

USER root

COPY fix-permissions /usr/bin/

RUN chgrp -R 0 "/usr/bin/start-kafka.sh"
RUN chmod -R g+rw "/usr/bin/start-kafka.sh"
RUN find "/usr/bin/start-kafka.sh" -type f -exec chmod g+x {} +


RUN chgrp -R 0 "/opt/kafka/config/"
RUN chmod -R g+rw "/opt/kafka/config/"
RUN find "/opt/kafka/config/" -type f -exec chmod g+x {} +


RUN chgrp -R 0 "/opt/kafka/bin/"
RUN chmod -R g+rw "/opt/kafka/bin/"
RUN find "/opt/kafka/config/" -type f -exec chmod g+x {} +


RUN chgrp -R 0 "/kafka/"
RUN chmod -R g+rw "/kafka/"
RUN find "/kafka/" -type f -exec chmod g+x {} +

CMD start-kafka.sh