Return-Path: <jens@viisauksena.de>
From: jens <jens@viisauksena.de>
Message-ID: <33547cb0-a540-e0b9-ffc7-99ac67c3d516@viisauksena.de>
Date: Tue, 21 Feb 2017 17:19:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Interface limit 127 in bat0?!
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

i observe a limit of 127 interfaces which can be hooked into bat0
where do i find this limit, or does somebody can tell me more about
this? Or, if it is a good idea to circumwent this at all? Or, if its
even possible in actual protocoll structure.

background:
Freifunk with tunneldigger and l2tp tunnel interfaces put a whole lot of
l2tp-eth interfaces in a bridge and hook the bridge into batman, which
make trouble and also doesnt feel like good practice. (i think to
circumvent this limit)

Freifunk with wireguard and gretap also have a lot of gretap tunnel
interfaces - but without bridging is limited to 127 interfaces
(we also experiment with vxlan which is limited to v4 in bridge
forwarding and by this not really an option - idea was to hook vxlan0 in
bat0 , which may be similar to bridging l2tp-eth)

you can find the test here (in german)
https://forum.freifunk.net/t/500-gretap-tunnel-interfaces-in-batman-einhaengen-fuer-wireguard/14245
or the wireguard in freifunk structures (batman network) here
https://forum.freifunk.net/t/wireguard-0-0-20161230-mit-linux-3-18-kernel-und-damit-gluon-v2016-2-2/14122/5

the error if you exceed the interface limit in dmesg :

|Error - can't write to file
'/sys/class/net/gre127/batman_adv/mesh_iface': Cannot allocate memory|


-- 
make the world nicer, please use PGP encryption

