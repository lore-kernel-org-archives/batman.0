Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 20 Apr 2016 09:53:35 +0200
Message-ID: <5335095.B1LOjD5IhA@bentobox>
In-Reply-To: <57173485.2060407@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <243525463.WEoUOFbSir@bentobox> <57173485.2060407@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4016589.O3gNBzL4u8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4016589.O3gNBzL4u8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 April 2016 09:49:25 Matthias Schiffer wrote:
> On 04/20/2016 09:39 AM, Sven Eckelmann wrote:
> > On Wednesday 20 April 2016 09:32:19 Matthias Schiffer wrote:
> > [...]
> >> As I've mentioned before, regarding the batctl support, I'd love to see a
> >> little library ("libbatadv"?) on top of libnl that could be used by batctl,
> >> alfred and other monitoring tools (like the ones we are using in the Gluon
> >> Freifunk firmwares).
> > 
> > Hm, then we would have to make everything ABI stable. So we would loose the 
> > flexibility of netlink (adding more fields) again just to keep the library 
> > stable.
[...]
> I don't understand. The same code that would we added to batctl and alfred
> could just be made a library with a nicer API, so other projects can easily
> reuse it. Of course, the library API/ABI would need to be designed in a way
> that keeps it extensible without breaking ABI.
> 
> I'm thinking of functions like "iterate over all originators", which would
> query the netlink API, and then just call a callback with the netlink
> attribute set for each originator. Just a thin wrapper making things more
> usable.

Ok, I thought that you want to have complete abstraction of the netlink
interface. But this now just sounds like you want to have some helper
functions to make the initial request to the kernel. The callback with
the netlink data is already part of libnl.

Kind regards,
	Sven

--nextPart4016589.O3gNBzL4u8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFzV/AAoJEF2HCgfBJntGOH8P/3ZFdYjWKhpo6cZ2HIMGN0Wy
Ntsr+x4Wr6QZzCwox5TQHx2hVO2a5kiCN5JEGMDbiRbHnQXp03dRgbi/eUnTOsIV
xelWdWLX5XZMagcvVdD9+sG23RA/lPRxLdKPNmE/OJSQGu+bmNPUe/kNu1Uozh5a
EJ5+RhzJgCXfl1U8qotH6zdJnGPuXWiyLBdmjxJFpomARMjgKYqtdN8zpfyJHZt8
r/JsCogfI9Hd/lb0xtuJ1uWJa89//v5L8MhLa8z50JL0p9Abh4+XApXSGqls7dJl
3wMKj/8sC7AgnYGsxyIPXUj51gIo6eyeaNvjNqh8SUZQZaQXVUlEugnvX6HLm2Ao
tnN8bnnOQmoHvIf6inq0ZWVS2Ti9DwFpOrsdpCNaTVIDxYBs3JXx/R0TGtqHmeAx
7UbMsI8K8efzoc2ljuXpwl6U7vMoWkrwMDnydnxqNJJaFI6C7nB9aem82HjXUO4M
qdy81hPgvXuDjt+JpUE3fVjeLOpFN0HSmlxbx6BykxDxSqy0oISM1MUO6qh4tLaz
KVe3e6HpiW0PxlLBuDq7X3HmEpTMit7xSTnVuAEfF8/XJBBg0/L5riUp3KZif9yn
jBBVGH/WjqP3Rw7/F1QcQvpJmWdQy/O/JnI2lINa5DTXkhtKmRkLX/cLnHjR4BTM
jU3xuvKS1s3zmVkEVXf4
=gJbc
-----END PGP SIGNATURE-----

--nextPart4016589.O3gNBzL4u8--

