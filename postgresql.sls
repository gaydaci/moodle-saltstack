install_postgres:
  pkg.installed:
    - pkgs:
      - postgresql
      - postgresql-contrib 

postgres-userdb:
  postgres_user.present:
    - name: moodleuser
    - password: 'moodlepassword'
    - user: postgres 
    - login: True           

  postgres_database.present:
    - name: moodle
    - owner: moodleuser

/etc/postgresql/16/main/pg_hba.conf:
  file.append:
    - text: 
      - "host    moodle          moodleuser      127.0.0.1/32            password"

# Workaround to avoid "Database connection failed" error
sudo -u postgres -H -- psql -d moodle -c "ALTER USER moodleuser WITH PASSWORD 'moodlepassword';":
  cmd.run


restart_postgresql_service:
  # Workaround to force service.running to restart the service.
  test.succeed_with_changes:
    - watch_in:
      - service: restart_postgresql_service
  service.running:
    - name: postgresql
    - enable: True
    - full_restart: True
