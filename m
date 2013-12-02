Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 2 Dec 2013 13:10:12 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7453@saturn3.aculab.com>
In-Reply-To: <529C8226.2040000@meshcoding.com>
References: <20131130191553.GA16735@n2100.arm.linux.org.uk>
 <529A46C4.9090906@meshcoding.com>
 <20131130230518.GC16735@n2100.arm.linux.org.uk>
 <529A8276.9060002@meshcoding.com> <529B47AA.8060403@meshcoding.com>
 <20131201171309.GD16735@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7451@saturn3.aculab.com>
 <529C8226.2040000@meshcoding.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Fix ARM BUILD_BUG_ON() errors
	withbatman-adv
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
To: Antonio Quartulli <antonio@meshcoding.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: netdev@vger.kernel.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, David Miller <davem@davemloft.net>

> From: Antonio Quartulli
> On 02/12/13 11:24, David Laight wrote:
> > ...
> >> The only solutions are: use the GCC packed attribute, redesign
> >> the structures...
> >
> > It is probably enough to mark the inner structure containing the
> > three byte fields 'packed'. Marking it aligned(1) might also have
> > the desired effect. The outer structure should then be ok. But
> > would need to use a specially named attribute so it doesn't get
> > removed.
>=20
> This may work with the structures I reported in a previous email, but
> it is not a good solution for us because we have other more complex
> substructs that cannot be packed that way.

You really don't want to have structures that need to be (say) 7 bytes
long and contain a 32bit value that will always be correctly aligned.

IIRC adding __attribute__((aligned(1))) to a structure isn't the same
as marking it 'packed' - it doesn't normally reduce the alignment
for structures (but can be used to force a reduced alignment on a
structure member - eg a 4byte aligned 64bit integer).

I don't have an arm compiler handy.

> I think we will simply duplicate the members and avoid substructs in
> our packets.

Can be easiest...


	David



