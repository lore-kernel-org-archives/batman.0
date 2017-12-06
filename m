Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 06 Dec 2017 17:55:42 +0100
Message-ID: <5212497.opIP8sI45N@bentobox>
In-Reply-To: <CAF=yD-JxdNu6eFha_V2650-UqZ3KNSzD4Oe2RLHEWd4cz1G6kA@mail.gmail.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <20171205143514.4441-3-sven.eckelmann@openmesh.com>
 <CAF=yD-JxdNu6eFha_V2650-UqZ3KNSzD4Oe2RLHEWd4cz1G6kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3624604.65xRJuR1V8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Network Development <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>

--nextPart3624604.65xRJuR1V8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 6. Dezember 2017 11:42:33 CET Willem de Bruijn wrote:
> On Tue, Dec 5, 2017 at 9:35 AM, Sven Eckelmann
> <sven.eckelmann@openmesh.com> wrote:
> > This file contains the relevant information to let userspace communicate
> > with batman-adv over generic netlink. The relevant genl enums for the
> > attributes and commands have the prefix batadv_genl. Renaming this file to
> > this name therefore represents the content better and avoids confusion 
with
> > the file which will contain the packet format definitions.
> >
> > Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> > ---
> >  MAINTAINERS                                        | 2 +-
> >  include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---
> 
> This and the previous patch changes uapi. That might break userspace
> applications that rely on it.

I am not aware of any application because all (alfred, batctl and some gluon 
integration) of them currently ship their own copy because distribution didn't 
catch up. And this is also the reason why I want to do it now - not later.

Kind regards,
	Sven
--nextPart3624604.65xRJuR1V8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlooIQ4ACgkQXYcKB8Em
e0Z2dg//aVIEsE1Q1yQrKVlNo8//RoXXRbMeKfe1eDEYqiqAwEIClkfC40pZPIYR
BKZTKxgbPzHuQ6+6eG50ujZzVDxu6QDXJmu8ZzF3Tvfa55piwEeuKKUHhGoZG5so
ATOXoImqlMi9VXpSawCWAwsLguziAPbvms9eWkQvSIp6ywFW3DtuFE1Dwo8HrQ+W
b65FxTckfn1l5XpT2D5nOSJ6IsDFgIex9k6aGW1mXiUXlZ/ougLfMz8vTujZWMnz
hWvPoR+43HoX+uyetuAad7dA/q887k4HcqY6WoKWwwzq2IEeCyP/9Pturq7t2XmF
xZAOG7xMXm2WSeNT+zlkDLgcPwT/eJzqyA3mFGGPQeSfQJTxxE0hGKqheZmnVL3D
dTgqcies9Km5Di/9qGe/s7urXxVMtUEl5uLA4xuKgt+aHLpsQauapB2Xhkrshnae
8fp2XOEeH3fq6qE9F9pluPYIKis+cqBQUE5YAOTBz+jYxzQXZZ1uKlGa8r+Be8eN
f0QOvv0FErCmSZIVc05xrJfaOtCecOSJEhrtXh34UyYrH5KhtHLHKHqumD6gasmN
HweHCmXIDOhL7oKKyE6YaLZvBIZAwwAHKLZSJEPCigj/K/125o9L0E4ZwXWXuzm/
GtbPDrrGaG4r/MMBrUQna+nlkc6MbH8N6YPTADIZPFw89cC6J1k=
=rz26
-----END PGP SIGNATURE-----

--nextPart3624604.65xRJuR1V8--

