Message-ID: <46CF07B9.8060903@bb.banban.jp>
Date: Sat, 25 Aug 2007 01:30:49 +0900
From: Lemonde <zukky@bb.banban.jp>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] robin
References: <38331.85.41.146.90.1187693478.squirrel@krisma.oltrelinux.com>
In-Reply-To: <38331.85.41.146.90.1187693478.squirrel@krisma.oltrelinux.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi, all. Hi, Antonio.

I've made up two ROBIN nodes on LaFoneras.
They works quite well.

---node.A as gateway---
root@OpenWrt:~# /sbin/brn -h
usage /sbin/brn
 -a : shows batmand -d 1
 -b : shows neighbors
 -d : shows non-direct neighbors
 -g : shows: OGs using NBs with non-direct GWs
 -v : shows all
 -l : loop every 2 seconds
 -h : shows help

root@OpenWrt:~# /sbin/brn -v
All Originators:
6.16.66.32           6.16.66.32 (128):      6.16.66.32 (128)
NBs:
6.16.66.32           6.16.66.32 (128):      6.16.66.32 (128)
NBs with non-direct GWs:
OGs using NBs with non-direct GWs:
root@OpenWrt:~#
-------------------------

---node.B as node------
root@OpenWrt:~# /sbin/brn -v
All Originators:
6.16.62.172         6.16.62.172 (126):     6.16.62.172 (126)
NBs:
6.16.62.172         6.16.62.172 (126):     6.16.62.172 (126)
NBs with non-direct GWs:
OGs using NBs with non-direct GWs:
root@OpenWrt:~#
-------------------------

ROBIN is so 0-config that I can't understand how it woks. :-)

regards,

zukky

P.S.
Antonio, your documents are so nice.


> Hi,
>
> I'm using BATMAN routing algorithm on an kamikaze based firwmare,
> realizing ROBIN (Routing Batman Inside) MESH: a 0-config, QoS capable mesh
> software which targets Atheros AP51 devices such as Meraki Mini or Fonera.
>   
