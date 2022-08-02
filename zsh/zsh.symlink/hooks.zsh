log_event()
{
  LOGFILE=~/.user_event.log
  echo "[$(date -Is)]: $@" >> $LOGFILE
}


git()
{
  case "$1" in
    checkout|co)
      /usr/bin/git "$@"
      log_event "Checked out: $@"
      ;;
    *)
      /usr/bin/git "$@"
      ;;
  esac
}
