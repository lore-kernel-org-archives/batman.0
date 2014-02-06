Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 6 Feb 2014 16:52:48 +0100
References: <1375184174.231615127.1391591164796.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <1375184174.231615127.1391591164796.JavaMail.root@spooler5n-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402061652.48854.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] question about VIS servera
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
Cc: michael.holcman1@free.fr

Hi Michael,

> Hello,
> I tried to configure the vis server. All is ok but i can't see the mesh
> network with the tool s3d (i installed the last version). I try to test
> batmand.

batmand is still officially maintained, although there is no development going 
on anymore. For the vis server of (layer 3) batmand, this software is not 
maintained anymore. You could consider switching to batman-adv + alfred + 
batadv-vis.

Also please note that you need the tool meshs3d running along with s3d. s3d is 
just a 3d display server, like for example your X server. You need an 
application to feed graphical data.

> Is there a bug ?

We can't exclude or confirm that from your report.

> Is there an another graphics server to see the global mesh ?

Since the various vis versions all output graphviz data, you can also use 
graphviz tools like dot or circo to print 2d maps of your mesh. That won't be 
that pretty though, I'm afraid. :)

Cheers,
    Simon
