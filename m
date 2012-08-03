Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Aug 2012 11:22:05 +0200
Message-ID: <2670997.NDZah7qDiQ@bentobox>
In-Reply-To: <BB2F02D2-9B93-465E-BB7D-FA13492511BF@gmail.com>
References: <BB2F02D2-9B93-465E-BB7D-FA13492511BF@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12927298.OnethyrSCq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv and routed subnets
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


--nextPart12927298.OnethyrSCq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 03 August 2012 11:08:37 Luca Pretto wrote:
> Hi folks,
> 
> I really need a bit of your help! I've already spent a week on this and I
> can't succeed! :(
> 
> I'm going to install a small mesh (12 nodes, initially) covering my city and
> linking some friends of mine. At the moment the equipment (Ubiquiti) is
> already installed, structured as AP-STA (PSK2) in one large LAN (all
> connections bridged L2) with one central dhcp/firewall serving the
> 192.168.9.0/24 subnet (now that's all inside this net only).
> 
> I would like to migrate the topology to a routed network, where the wireless
> mesh nodes have IPs allocated inside 10.9.0.0/16, and below each one of
> these nodes there will be a local LAN with reserved subnet (IP offered by
> OpenWRT through dnsmasq). I've done some experiment with OLSRd and I got a
> working system that way, but I'd REALLY LOVE to use batman-adv instead.
> Some of the networks already have internet connectivity, that will be
> shared through the mesh to whom needs it.
> 
> 10.9.11.1 <----> 192.168.11.0/24 --> 192.168.11.1 (internet gateway)
> 
> 
> 10.9.12.1 <----> 192.168.12.0/24
> 
> 
> 10.9.13.1 <----> 192.168.13.0/24 --> 192.168.13.1 (internet gateway)
> 
> 
> 10.9.14.1 <----> 192.168.14.0/24
> 
> 
> 10.9.xx.1 <----> 192.168.xx.0/24
> 
> Batman-adv will take care of the routing inside the wireless mesh (links "
> || " in the diagram). Anyway, I need that any host on the 192.168.xx.0/24
> subnets will be able to talk to each other.
> 
> How can this be done with batman-adv?

First thing: batman-adv doesn't route (as in l3 routing). batman-adv creates a 
distributed switch on l2 (so, batman-adv does path finding). Therefore, 
batman-adv doesn't care about the l3 stuff.

And the stuff you've mentioned above is l3 stuff. So out of scope for batman-
adv. Either you create static routes, use proxy arp or use another software 
that distributes the l3 routes.

Kind regards,
	Sven
--nextPart12927298.OnethyrSCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQG5g9AAoJEF2HCgfBJntG+qUQAMdEWktNwsjtO43j3LQ3+e6p
0VewOCnE3F4WBntYG0l53TKAVj2dngvXcTUCJ6YyS7MXZ8N2cn3q1G1+bPLOvgvf
wAneltC8Z7P7CP12j3WGiRUUKL1JbfEJyZyIgaLxNjNPGXa1z5fdILvf2kRkyov0
y04vRjZlsEFqMcOTAH/5f/c4eH1AC1RX75nk4e7F2OIq5pPkRJgQco/XYyMu48gz
DR1soRMDjTOksXkn6+GvUXjEng4mq7GlvoJvzV6r1XYp7e8YTUqXt7NS5+Afvs6H
IMyYRc6O485Iks6n3dXtlpSZtUd6P0Lcijx2ocEW5lyxlHwl8GiT0iMbHwxh+v+B
FnsK2L6YVNfOhAYF5rz63dPqn+5/pARm3iKpC0upPlm91XuGuTkCOLJEjF3vSV7r
9Sf2SF1CKqvU1CMjRs1SY5M+ANuAwkkqR1UtqshPYyw7jbDuTvH+M6/rA52Vu2iy
TQ30v/nGkZG57OLmNIus5iMAVvrm4LNB8Wnp4itQMAQojr5KAWLuriOtYfLa7d/+
oNhQwTck1PhX86PyhoMotogdCn18Vr+BrXanBhYtNS20YrC9xe10jlP2GmoZHT/6
+DGg4h8/iUVtnvW9Gq/jjCcEA2jFVss8KITxO0AExRYfjH5Ny5t3vKMUhcniN4vN
QOiCqCWMLJOEc8WF56ns
=tLa7
-----END PGP SIGNATURE-----

--nextPart12927298.OnethyrSCq--

