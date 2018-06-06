Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2018 10:11:29 +0200
Message-ID: <2037747.o1UMTMsDbr@bentobox>
In-Reply-To: <20180606053951.5314-1-sven@narfation.org>
References: <20180606053951.5314-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3444819.ezMEe1Om2i";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Initialize memory
 for station_info
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

--nextPart3444819.ezMEe1Om2i
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 6. Juni 2018 07:39:51 CEST Sven Eckelmann wrote:
> batadv_v_elp_get_throughput is calling cfg80211_get_station with a pointer
> (sinfo) to some uninitialized memory on the stack. But most of the
> implementations behind cfg80211_get_station will not initialize sinfo to
> zero before manipulating it. For example, the member
> &struct station_info.filled is often only modified by using a read (of
> possibly uninitialized/random memory), an OR operation and then a write of
> the new value back to the original memory address. A caller without a
> preinitialized &struct station_info.filled can then no longer decide which
> parts of sinfo were filled in by cfg80211_get_station.
> 
> The caller of cfg80211_get_station must therefore take care that sinfo (or
> at least sinfo.filled) is initialized to zero. Otherwise, the caller may
> tries to read information which was not filled in and is therefore also
> uninitialized. In batadv_v_elp_get_throughput's case, an invalid "random"
> expected throughput may be saved for this neighbor and thus the B.A.T.M.A.N
> V algorithm may switch to non-optimal neighbors for certain destinations.
> 
> Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
> Reported-by: Thomas Lauer <holminateur@gmail.com>
> Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:

Just got he information from Johannes that it should be changed in cfg80211:

<johill> ecsv: I guess cfg80211_get_station() would be better in case anyone else starts using it

Kind regards,
	Sven
--nextPart3444819.ezMEe1Om2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsXlzEACgkQXYcKB8Em
e0Y0KA/+L0Gy2MzgEmAE+bh/UKg5swmEA5Ra5fuEJJAI/lGPAKLlEOgdfxB157HR
hwT7wBQFXHRGqDJCChDfio3dEyTGC6vJ997IVIzx1Rxd/ADfTRGspSQ5joFIduK+
rXAH8ZrynIh39VpYzp49OCtdmadYTYoa1FAZsUyjHGKB5o2ng+VZD5M6v6M3d5iA
abQoCqmlVAfcXd/h42hrT+yVa+08PV1Uru93uF7UWUOS4x5QUzdE8DUkS0r3MHQ6
wFHE0W3mD8LZGQ+RtA6IYD2ewLZAdgVE61EetTJClyatUsOIO3xQEGInFkZVtiGQ
4t+MOTtHvTXPExgrwdJ99jlMtlNNQs7mXKnflXg/A1i3UHaiXiTGgkkQvYZYS0gD
lmeMYs2PBhvctoQv8howj9qYm31A8iJI5c0E3JxWK4+w/iUZHdnglfoGsV3t/Q9c
PRRR3ROyJz28rgTCZr9EcrB26wRH8E+CDolBZQgqAKyengHboRqSssx7vd9T9IxB
+d8m+a5eM73Rz1hdLKLU/YbDuuXwE623p2hXdlLD940nEP7PBbyGc/Y4n8CKhDzo
aKtnarz1L9Fm1eWfArGIt7n50YzBrTsZCwI1gLKEAGKLYDMXCzPXJUhXGSQ5umBY
C9U6oM+A4tbtyq0uQYqHoWq4n5Msp+xYsa3CQo+axEYt70ETAbU=
=yHsQ
-----END PGP SIGNATURE-----

--nextPart3444819.ezMEe1Om2i--

