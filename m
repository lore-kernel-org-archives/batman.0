Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Sun, 6 Sep 2009 12:50:40 +0200
References: <4AA34865.9000203@rsm-freilassing.de>
In-Reply-To: <4AA34865.9000203@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909061250.40558.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
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

Hello Michael!

Batmand checks and deliberately blocks users from announcing 0.0.0.0/0 - this 
could cause the notorious black-hole problem we have experienced in the old 
days when using OLSR. Also we think it is important that we can explicitly 
tell a Batman node to use Internet gateway functionality or not. 

Default routes in a mesh can be really annoying and break network 
functionality. If you only have one default gateway in your Batmand network 
and really know what you are doing you can actually override this check with a 
simple trick. 

As a workaround you can announce two subnetworks 0.0.0.0/1 and 128.0.0.0/1 
instead of 0.0.0.0/0.

batmand -a 0.0.0.0/1,128.0.0.0/1 <your interface>

Cheers,
Elektra
