# Export Apache Maven 3.8.4 home path
#
if [ -z "$MAVEN_HOME" ]; then
    case "$OSTYPE" in
        darwin*)
            export MAVEN_HOME=/Library/apache-maven-3.8.4
            ;;
        linux-gnu*)
            export MAVEN_HOME=/opt/apache-maven-3.8.4
            ;;
        *)
            # do nothing!
            ;;
    esac
fi
export PATH="$MAVEN_HOME/bin:$PATH"
