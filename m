Return-Path: <matthewa@ihostsolutions.com.au>
From: Matthew Anderson <matthewa@ihostsolutions.com.au>
Date: Thu, 1 Jul 2010 03:22:11 +0000
Message-ID: <FB833AE6C7173C449F93C243719A4C8F0974886B@Exchange2010.corit.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Dual radio BATMAN Advanced implementation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Guys,

I'm looking at making a small mesh network using dual radio's and BATMAN ad=
vanced and was after some advice to make sure I'm heading the right directi=
on. The application is just a basic hotspot covering a large area, all traf=
fic would need to come back to the captive portal server which would be 2-3=
 hops away maximum.

I'm using OpenWRT with a 5.8GHz 802.11n radio for backhaul and 2.4GHz 802.1=
1b/g for serving non BATMAN clients. I'm going to run BATMAN Adv on the bac=
khaul network and bridge it to the client radio which would effectively mak=
e it one giant layer 2 mesh. In this situation, would users on the b/g radi=
o's be able to roam between nodes?
Am I better off removing the bridge between the mesh and the client radio a=
nd use layer 3 routing or NAT instead?

Eventually I'd like to run PPPoE and do some point to point VPN's over the =
mesh but the hotspot is my starting point. If anyone has any constructive c=
riticism or words of wisdom it would be much appreciated.

Thanks
-Matt
