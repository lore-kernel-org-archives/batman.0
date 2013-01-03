Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 09:57:03 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <50E31C20.6010604@altermundi.net>
 <ABCFB139-9D63-48DB-8C1F-8A0D6E10AD02@stephan.homeunix.net>
In-Reply-To: <ABCFB139-9D63-48DB-8C1F-8A0D6E10AD02@stephan.homeunix.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301030957.04081.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, January 03, 2013 07:28:02 Jan L=FChr wrote:
> >> The client should use 6a:4b:93:de:00:84 as a gatway, since it provides
> >> much higher data rates - however, it is stuck at aa:31:0e:4a:0f:1d.
> >=20
> > I have observed the same behavior.
>=20
> That's quite frustrating. Can I debug, when and why batman-adv actually
> chooses as specific gateway?

Yes, you can. Enable the batman-adv debug log at compile and runtime. While=
=20
retrieving the 'batman' log messages you should see something like:
Adding route to gateway ..
Changing route to gateway ..
=46ound new gateway ..
etc

Maybe you can post the result here ?

Cheers,
Marek
