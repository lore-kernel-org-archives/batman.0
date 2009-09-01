Return-Path: <linus.luessing@web.de>
Date: Tue, 1 Sep 2009 22:47:02 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090901204702.GA9632@Linus-Debian>
References: <20090830013647.GA26017@Linus-Debian>
	<20090830195553.GA2410@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20090830195553.GA2410@pandem0nium>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output in
 dot-file-format
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Ok, now with a larger setup I found two smaller problems. I didn't
have the time to look at the source code again yet, but I'll just post
the things we noticed here.
First of all, not all interfaces get added to a subgraph. As an example
vis-output I have this [0] file, but unfortunately the lines in brackets
are not there, but should to avoid splitted graphs.
Secondly, it seems that a vis-client is just sending to the
vis-server its prefered interface plus quality to a neighbour, not
all possible links plus qualities to the neighbour. As a
network-administrator I'd like to have these information as well
to be able to check if an interface might be broken for example.

Cheers, Linus

[0]:
--------
digraph {
        "00:50:bf:d6:fd:b0" -> "00:22:b0:44:94:02" [label="1.0"]
        "ca:5f:0b:67:03:c7" -> "00:ff:4d:f1:04:c5" [label="4.553"]
        "00:50:bf:d6:fd:b0" -> "00:ff:82:74:9c:eb" [label="HNA"]
        subgraph "cluster_00:50:bf:d6:fd:b0" {
                "00:50:bf:d6:fd:b0" [peripheries=2]
                "ca:5f:0b:67:03:c7"
        }
        "00:22:b0:98:87:de" -> "00:22:b0:98:87:fa" [label="1.15"]
        "06:22:b0:98:87:dd" -> "06:22:b0:44:94:5d" [label="1.7"]
        "00:22:b0:98:87:de" -> "00:e0:29:39:34:d7" [label="1.15"]
        "06:22:b0:98:87:dd" -> "00:16:cb:ba:4a:f4" [label="HNA"]
        "06:22:b0:98:87:dd" -> "00:19:d2:7a:ba:21" [label="HNA"]
        "06:22:b0:98:87:dd" -> "00:ff:ca:4d:a5:e7" [label="HNA"]
        "06:22:b0:98:87:dd" -> "00:22:b0:98:87:dd" [label="HNA"]
        "06:22:b0:98:87:dd" -> "00:19:7e:6a:8a:27" [label="HNA"]
        subgraph "cluster_06:22:b0:98:87:dd" {
              ( "00:22:b0:98:87:de" )
                "06:22:b0:98:87:dd" [peripheries=2]
        }
        "00:22:b0:98:87:fa" -> "00:22:b0:98:87:de" [label="1.15"]
        "06:22:b0:98:87:f9" -> "06:22:b0:44:c6:59" [label="1.3"]
        "06:22:b0:98:87:f9" -> "06:22:b0:98:85:5b" [label="1.0"]
        "06:22:b0:98:87:f9" -> "06:22:b0:98:8c:33" [label="1.0"]
        "06:22:b0:98:87:f9" -> "00:22:b0:98:87:f9" [label="HNA"]
        "06:22:b0:98:87:f9" -> "00:ff:1b:01:51:12" [label="HNA"]
        subgraph "cluster_06:22:b0:98:87:f9" {
              ( "00:22:b0:98:87:fa" )
                "06:22:b0:98:87:f9" [peripheries=2]
        }
        "06:22:b0:44:c6:59" -> "06:22:b0:98:87:f9" [label="1.15"]
        "00:22:b0:44:c6:5a" -> "00:22:b0:98:8c:34" [label="1.85"]
        "06:22:b0:44:c6:59" -> "06:22:b0:98:85:5b" [label="1.0"]
        "06:22:b0:44:c6:59" -> "06:22:b0:98:8c:33" [label="1.32"]
        "06:22:b0:44:c6:59" -> "00:22:b0:44:c6:59" [label="HNA"]
        "06:22:b0:44:c6:59" -> "00:ff:d8:85:d7:fa" [label="HNA"]
        subgraph "cluster_06:22:b0:44:c6:59" {
                "06:22:b0:44:c6:59" [peripheries=2]
                "00:22:b0:44:c6:5a"
        }
        "00:22:b0:44:94:02" -> "00:50:bf:d6:fd:b0" [label="1.15"]
        "06:22:b0:44:94:01" -> "00:22:b0:44:94:01" [label="HNA"]
        "06:22:b0:44:94:01" -> "00:ff:af:cb:d6:64" [label="HNA"]
        subgraph "cluster_06:22:b0:44:94:01" {
              ( "00:22:b0:44:94:02" )
                "06:22:b0:44:94:01" [peripheries=2]
        }
        "06:22:b0:98:85:5b" -> "06:22:b0:44:c6:59" [label="1.15"]
        "06:22:b0:98:85:5b" -> "06:22:b0:98:8c:33" [label="1.62"]
        "06:22:b0:98:85:5b" -> "00:ff:00:02:cb:82" [label="HNA"]
        "06:22:b0:98:85:5b" -> "00:22:b0:98:85:5b" [label="HNA"]
        subgraph "cluster_06:22:b0:98:85:5b" {
                "06:22:b0:98:85:5b" [peripheries=2]
        }
}

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKnYhFAAoJEBKw7u43QNpfK+8QAJVWhilhBIqIi3FSEHt5HWU9
DbtJAw+HjALAOYokBSa+lBrdv202/820K/fi3QI7ETKUMTQyoOKKXNR0HtxtziQk
3JQckwAvpBwGAVfVhqoGO9qvU5+qBfO7TlspyoeD4BQbS308KcQwI1jBhGDPyl8x
iMFjt7hhtHHCl6FG46BnVFSj5JQy75K4JNy/E23KYHp2/UCM6HCASxFdIN/9MmOV
HtGLx6TYV21gGVrOBaU1EvIJp1+ASWSVT6RHNcbdLTaHQs7fpJC9JcyEtEYkqR97
pnys6SIo1buvvnIhI8uf955V2r5r7udS8j8dCHABA9DKhRLE5eYaJWadnCvW5xSK
GlFvlCFKm2BPAZHmFdNagPCpPc7+nFMja+ri2KJ+9/EvZ93QT+DmReQg3OlTb0wK
yop4T1YVehndLuknZi+i6ea7ATFiFAUhzTtO//ufB955MnmcYlmim3xUy4Qyigk7
Xd9Z98QmoUXul/utpEsv6r5wQCeFJ06PGfQmq6Y2YYoK9wvJec3nNfUtSUjO++Yr
EfvbWjVXRkMbcd3AdLcLaK4mEYNGQb6arIyBacOWDTbFIMCQ6hT+7gTzO594e9VB
ilPmWbWlLUSxYtI1w2Zznb2f0RmITleUYmvefunld0CIZFJkeWBEjGT4EOtCpB3e
kwr8q9yCqK248DTRcjz3
=2BdE
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
