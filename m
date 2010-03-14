Return-Path: <aaron@lo-res.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1077)
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
Date: Mon, 15 Mar 2010 00:32:07 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <9EA0CC83-37A0-497E-A7EB-79E35F3427A6@lo-res.org>
References: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


On Mar 11, 2010, at 3:12 PM, Michael Fazio wrote:

> Hello,
>=20
> 		My name is Michael. I am currently working on a large =
robotics project and I am thinking of using B.A.T.M.A.N to facilitate a =
MANET to communicate between a number of bots and a base station. I was =
hoping to get a bit of information regarding the suitability of =
B.A.T.M.A.N for such an application. Any information would be helpful =
(general or specific). Here are some of the details of our project.
>=20
> We will be using up-to 14 bots in our project (each must be network =
aware).

It will scale to 14 nodes :)

(...)

>=20
>=20
> I was hoping to know what type of issues I might run into using =
B.A.T.M.A.N adv in such a scenario. For instance, what kind of =
throughput might I expect in the described environment? Link stability =
issues? General suitability? How would B.A.T.M.A.N compare to OLSR or =
Babel? I am really interested in anything that anyone has to offer.
>=20
I think all protocols will be fine for 14 nodes. But please report your =
findings.
I assume that B.A.T.M.A.N. will be a bit slow (depends on the timeing =
settings of course) when you have many routing switches/high mobility =
(in the presence of long paths) but that it will find good paths instead =
(there is always a trade-off between these things).

It should be easy enough to try out all three protocols! I am especially =
interested in a highly mobile setup.


> The reason I am pushing for B.A.T.M.A.N is because of the ability for =
us to develop our application layer using IPv4 TCP/UDP on-top of a mesh =
network driven by routers running openWRT & B.A.T.M.A.N. I want to take =
as much network layer knowledge away from out application layer.

IMHO you will have this with all three protocols.

Best,
a.

