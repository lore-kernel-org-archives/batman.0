Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 05 Nov 2018 12:33:25 +0100
Message-ID: <39526497.qhSXs3GhTV@bentobox>
In-Reply-To: <20181105111050.GA2095@nanopsycho>
References: <20181104193314.18104-1-sven@narfation.org>
 <20181104193314.18104-2-sven@narfation.org>
 <20181105111050.GA2095@nanopsycho>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10348053.j0JmP2492X";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add infrastructure for
 netlink config manipulation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@mellanox.com>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart10348053.j0JmP2492X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 5. November 2018 11:17:08 CET Jiri Pirko wrote:
> Sun, Nov 04, 2018 at 08:33:13PM CET, sven@narfation.org wrote:
> >The batman-adv configuration interface was implemented solely using sysfs.
> >This approach was condemned by non-batadv developers as "huge mistake".
> >Instead a netlink/genl based implementation was suggested.
> >
> >The different key-value pairs used for the configuration of batman-adv can
> >be split in three classes (sharing most of the setup code):
> 
> This is problematic. In general, TLV approach is frowned upon.
> What is a usual way of exposing options over netlink are well-defined
> netlink attributes. For example:
> 
> BATADV_ATTR_SOME_THING
> BATADV_ATTR_ANOTHER_THING
> 
> The set and get commands usually work with an object. So if and object
> have multiple options/attributes, it can we set via a single set
> command. But this is more free. Depends on what makes more sense.

Hm, so you first  say that I should not do that and then say that it can be 
done because it operates on the same object? Classes in my description are 
basically your object.

But let assume for now that you don't want to use this approach, we can also 
have for example something like:

BATADV_CMD_SET_BRIDGE_LOOP_AVOIDANCE which then receives either one or no flag 
BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE to enable/disable bridge loop avoidance. And 
a command BATADV_CMD_GET_BRIDGE_LOOP_AVOIDANCE which tells the client using 
BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE whether it was enabled or not. A dump 
functionality for all options for this batadv object/class would then not 
exist.

Kind regards,
	Sven
--nextPart10348053.j0JmP2492X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvgKoUACgkQXYcKB8Em
e0auWQ/+IqmLnrWSSRYBn7dYp9mj2JoFv0VT3jV+j7eH9xrXtYTmdwVWXEbeeOHC
OjIi+xdbEY2fcyC6Ua8AdWz+RiScUzVOctIYHQ5I18S5r4oMFNNyp9FdArkWcuTZ
WycAF6NVGub5qQZffX+134kiXNPJOcbZq/xENP+4oQVZQyFE9N28ifFh5LLX8BdT
X9rQzkqsKM2PoZc8YUKcmpZ4QuaYRqcN/QvywBxAE0QzIKNOW1mQxV3Y7KB7JNn0
NuaY4ull5/9CXkrCx/BtP7IINhm3t0yVBKssV0wOe4MxICO62B75hk7BB0V6P1Ub
rDyIHMs5/8HREoEOLGPqauKXf2+vtb7JU8vOQugvuEO17Zw/YTQCnsLzfB3b/uRx
jDcYFA2vj9hbHWAnvxriGLb45+/gR2hTCDffBNDm9DU1IE1ZIxjpucxDRwdAZ0Rt
vxhP8OxCl9W8/eKUUCZ3kHI2I+hbqiPXGSOOZDbgQBj5GfUyM2Kiql7FWs5EL/gl
n0avd/PpjwjGCdca7hbHuqeJ/pGjUesaPVbFtA5vnwClm5Kvc+i+sQ5mlKyDII/X
KCrSuL8UCnsyze24TJVmGCu84eW2bFMduWhI90Z+e6MF94mqb208fWAOigdew7Zv
3txDh/L0Eg7vrZ5/qHChPuNO2aGBTij46U70RbOYbyMADQs2e1E=
=f44Q
-----END PGP SIGNATURE-----

--nextPart10348053.j0JmP2492X--

