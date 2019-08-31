Return-Path: <MAILER-DAEMON>
From: batman.mexon@spamgourmet.com
Subject: How to give stable MAC address to batman-adv device?
Message-ID: <3af7c293-5b8c-535c-2049-eef51b36da81@exon.name>
Date: Sat, 31 Aug 2019 21:33:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I'm trying to use batman-adv to fix wifi signal problems with a few
Raspberry Pis.  So far it's more-or-less working.  I'm using dnsmasq on
the main gateway node to serve IP addresses over DHCP.

One problem I have is that the bat0 device has a different MAC address
each time it starts.  My Raspbery Pis reboot each day on a cron job and
each time they get a new MAC.  This causes dnsmasq to give them a new IP
address.  This causes problems talking to other nodes with outdated DNS
caches, as well as being irritating when I try to use ssh and it thinks
the nodes are "impersonating" each other.

Is there a way to force batman-adv to use a stable MAC address?

Thanks,
Matthew Exon

