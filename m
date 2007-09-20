Message-ID: <46F26BDF.7030602@ddmesh.de>
Date: Thu, 20 Sep 2007 14:47:27 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] running batman as non-root
References: <46EA5834.6030703@ddmesh.de>
	<200709141655.16137.lindner_marek@yahoo.de>
In-Reply-To: <200709141655.16137.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,

Thanks, I no use the following setting in /etc/sudoers:


# Cmnd alias specification
Cmnd_Alias      BATMAND=/usr/bin/batmand -c -b -d [0-9]

# User privilege specification
root    ALL=(ALL) ALL
www-data        ALL=NOPASSWD: BATMAND

