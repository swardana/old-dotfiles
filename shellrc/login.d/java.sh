# Export JAVA_HOME path environment
#
if [ -z "$JAVA_HOME" ]; then
    case "$OSTYPE" in
        darwin*)
            export JAVA_HOME=$(/usr/libexec/java_home)
            ;;
        linux-gnu*)
            export JAVA_HOME=/usr/lib/jdk-17.0.1+12
            ;;
        *)
            # do nothing!
            ;;
    esac
fi
export MANPATH="${MANPATH}:${JAVA_HOME}/man"
export PATH="${PATH}:${JAVA_HOME}/bin"
