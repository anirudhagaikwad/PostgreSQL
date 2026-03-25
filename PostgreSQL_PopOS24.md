Here's a complete, step-by-step guide to install **PostgreSQL** and **pgAdmin 4** on **Pop!_OS 24.04** (which is Ubuntu 24.04-based, so the process is nearly identical).

### 1. Update Your System
Open the terminal and run:

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Install PostgreSQL (Recommended: Latest Version via Official PGDG Repo)

Pop!_OS 24.04's default repositories include PostgreSQL 16. For the latest version (PostgreSQL 17 or 18), use the official PostgreSQL repository.

#### Add the Official PostgreSQL Repository
```bash
sudo apt install -y curl ca-certificates gnupg

# Add the signing key
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /usr/share/keyrings/postgresql.gpg

# Add the repository (for Pop!_OS 24.04 / Ubuntu 24.04)
echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list

sudo apt update
```

#### Install PostgreSQL
For the latest version (e.g., 18 — check available versions with `apt search postgresql-`):

```bash
sudo apt install -y postgresql-18 postgresql-client-18 postgresql-contrib-18
```

(Replace `18` with `17` or `16` if you prefer a specific version.)

#### Start and Enable the Service
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo systemctl status postgresql   # Should show "active (running)"
```

#### Basic Setup (Set Password for postgres User)
```bash
sudo -u postgres psql
```

Inside psql, run:
```sql
ALTER USER postgres PASSWORD 'your_strong_password';
\q
```

Now you can connect with `psql -U postgres -h localhost`.

### 3. Install pgAdmin 4

You have two main options for pgAdmin 4:

#### Option A: Desktop Mode (Recommended for Desktop Users – Native App)
This gives you a standalone desktop application.

```bash
# Add pgAdmin repository (if not already added)
curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/pgadmin.gpg

echo "deb [signed-by=/usr/share/keyrings/pgadmin.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list

sudo apt update

# Install desktop mode
sudo apt install -y pgadmin4-desktop
```

After installation, search for **pgAdmin 4** in your applications menu and launch it.

#### Option B: Web Mode (Browser-based, runs as a service)
```bash
sudo apt install -y pgadmin4-web

# Configure pgAdmin (set admin email and password)
sudo /usr/pgadmin4/bin/setup-web.sh
```

Then access it in your browser at: `http://localhost/pgadmin4`

(You can also install both modes with `sudo apt install pgadmin4`.)

### 4. Connect pgAdmin 4 to PostgreSQL
1. Open pgAdmin 4 (desktop or web).
2. Right-click **Servers** → **Register** → **Server**.
3. In the **General** tab, give it a name (e.g., "Local PostgreSQL").
4. In the **Connection** tab:
   - Host name/address: `localhost` (or `127.0.0.1`)
   - Port: `5432`
   - Username: `postgres`
   - Password: the one you set earlier
5. Save and connect.

### Optional: Snap Version for pgAdmin (Easier but Isolated)
If you prefer a quick snap install:

```bash
sudo apt install snapd
sudo snap install pgadmin4
```

Then launch with `pgadmin4`.

### Troubleshooting Tips
- **Port 5432 in use?** → Check with `sudo ss -tuln | grep 5432`
- **Permission issues?** → Ensure your user can connect (edit `/etc/postgresql/*/main/pg_hba.conf` if needed, then `sudo systemctl restart postgresql`)
- Firewall (if enabled): `sudo ufw allow 5432/tcp` for PostgreSQL, and `sudo ufw allow 80/tcp` or 443 for pgAdmin web.
- Check versions: `psql --version` and `pgadmin4 --version` (for desktop).

You should now have a fully working PostgreSQL + pgAdmin 4 setup on Pop!_OS 24.04.
