Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Aug 2016 08:09:01 +0200
Message-ID: <18615835.C1DB5WGuIh@bentobox>
In-Reply-To: <1877539.fInDOEgoYM@bentobox>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <20160803234329.GD16866@otheros> <1877539.fInDOEgoYM@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4938420.ct00AP829k";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Simple (re)broadcast
	avoidance
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

--nextPart4938420.ct00AP829k
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 4. August 2016 07:56:44 CEST Sven Eckelmann wrote:
> On Donnerstag, 4. August 2016 01:43:29 CEST Linus L=FCssing wrote:
> > On Wed, Aug 03, 2016 at 11:25:53PM +0200, Linus L=FCssing wrote:
> > > On Wed, Aug 03, 2016 at 09:59:27PM +0200, Sven Eckelmann wrote:
> > > > Isn't this causing the reference counting cycle (aka really, really,
> > > > really bad):
> > >=20
> > > Hm, I see what you are getting at. Could indeed be a nasty bug...
> > >=20
> > > But, actually, just tested in VMs, seems like I'm getting a call to
> > > batadv_hardif_neigh_release() just fine. Which means it counted to
> > > zero successfully o_O?
> > >=20
> > > I don't understand why it seems to work right now :D. Will dig deeper.
> >=20
> > Ok, I think it just works because hardif_neigh_create()
> > intializes the nodes refcount to one (in contrast to other allocating
> > functions which initialize to 2). In the end, once
> > neigh_node_create() finishes, it stays at one.
> >=20
> > So the regular purging routines will break the cycle in the end
> > when they reduce the refcount of the hardif_neigh_node to zero.
>=20
> Ok, looks like the neigh_list edge in my graph is incorrectly there.
[...]

Just checked the code and my example graph seems to be correct in regards o=
f=20
this edge. There is an reference for the list in the code:

    static struct batadv_neigh_node *
    batadv_neigh_node_create(struct batadv_orig_node *orig_node,
    			 struct batadv_hard_iface *hard_iface,
    			 const u8 *neigh_addr)
    {
    [...]
    	/* extra reference for return */
    	kref_init(&neigh_node->refcount);
   =20
    	kref_get(&neigh_node->refcount);
    	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
   =20
    [...]
    	return neigh_node;
    }

The function which doesn't get a reference for its list is
batadv_hardif_neigh_create. It doesn't store a reference in
batadv_hardif_neigh_create for the list because its lifetime doesn't depend=
 on
the list & just uses it as management helper and deletes the list entry in =
its
_release function). But this list cannot be found in the example graph.

Kind regards,
	Sven
--nextPart4938420.ct00AP829k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXotv9AAoJEF2HCgfBJntGXEsQAI18DEPx7N2RItZUOnvNAmzL
SUl124R2pImbKA08Te+pr7fv1biK2EKHSGtVq3QFQVSPGi0VlfM+FKejDtadNAvS
ookZFjLjeszz4e6U0rG2Xaww7sJ2ozUKwXYdKqoecsuMDMphbPPRaEw2BgvuLlPK
b5vbqFYLHlLd6d0tim1IcU2POxS1dli2kFdpa+bTZ2fqc91jQafSgDFtzmGgOgyS
GKcEFVmc2gtkiCo+DYEnU0PrtXLaR6wTaUFq3X1HFYmiSRLsfYJKBvGHX5Tkeu7v
+2Ahn9H1+OD6ieXQcTwARk0vB/AbE0ktuPtmo7mzEhsb03w3pVu3Gbym1nFS88zc
VlklNEMdKiagrNYAOY0LEqldv5LfA9kwKCv9QT+9KuuWVZGvgaa5Gvj+e7HfUT8G
gOp/BzKfAc0k+F+JW0nvzj6NjCAKbTOyWDZTtDQJg8zblzb0VQe2JHkCpyfhFjp1
ie/D9k4sVD1FhxUpjUPFaNGO9egLBcxEyS7yeU8G66PCLnOBVt7zhK8+UgGGoFg0
4kVQJovKrjNavfxu/p2JPT6FJLbNCOGtWmv9UTmNIyTYKEl98Ta18/REvqoP99Kv
uUAc/bVnuc7mVZzA1sv3bxh+GRjwUtGpQhD0YHCo0GrayJVWEYzDXrYE2Hf1lhYm
DYW/bQtrmL1CFHNCRoma
=mIOf
-----END PGP SIGNATURE-----

--nextPart4938420.ct00AP829k--

