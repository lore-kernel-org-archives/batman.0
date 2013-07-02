Return-Path: <ajeetbbr@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHQ_bghvU1=AR=+Kk4XvAZoWTjyVT6u74MnkgM_Y+4hcUR9MxA@mail.gmail.com>
References: <CAHQ_bghvU1=AR=+Kk4XvAZoWTjyVT6u74MnkgM_Y+4hcUR9MxA@mail.gmail.com>
Date: Tue, 2 Jul 2013 11:28:48 +0530
Message-ID: <CAHQ_bgj6EoSPVW7iiYcf3KMCUX+shpPSNThxjTY_Qa+vtNw0xQ@mail.gmail.com>
From: ajeet singh <ajeetbbr@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] ttcrc value
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hello all,
We are getting the same value of ttcrc always even after restarting the nodes.

Please check the bellow TCPDUMP log,

Log 1
09:05:17.118462 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
f4:7b:5e:88:7d:a0, seq 2246235905, tq 255, ttvn 1, ttcrc 15939, ttl
50, v 14, flags [...F.], length 26
09:05:17.118764 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
f4:7b:5e:88:7d:a0, seq 2246235905, tq 255, ttvn 1, ttcrc 15939, ttl
50, v 14, flags [...F.], length 26

Log 2 ( After restart)
 00:12:29.480397 BAT f6:7b:5e:88:7d:a0: OGM IV via neigh
aa:aa:03:00:00:00, seq 2864163091, tq 255, ttvn 1, ttcrc 15939, ttl
2, v 14, flags [.....], length 26
 00:12:29.520254 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
aa:aa:03:00:00:00, seq 31648486, tq 255, ttvn 1, ttcrc 15939, ttl 50,
v 14, flags [...F.], length 26
 00:12:32.488390 BAT f6:7b:5e:88:7d:a0: OGM IV via neigh
aa:aa:03:00:00:00, seq 2864163092, tq 255, ttvn 1, ttcrc 15939, ttl
2, v 14, flags [.....], length 26
 00:12:32.536432 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
aa:aa:03:00:00:00, seq 31648487, tq 255, ttvn 1, ttcrc 15939, ttl 50,
v 14, flags [...F.], length 26


 Is it normal operation?

 Thanks
 Ajeet
