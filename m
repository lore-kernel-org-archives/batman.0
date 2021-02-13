Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Use netif_rx_any_context().
Date: Sat, 13 Feb 2021 18:10:29 +0100
Message-ID: <10903423.uF0vj5h9zV@sven-edge>
In-Reply-To: <20210213170204.3092113-1-bigeasy@linutronix.de>
References: <20210213170204.3092113-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13446814.T51Icr5x54"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

 
--nextPart13446814.T51Icr5x54
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] batman-adv: Use netif_rx_any_context().
Date: Sat, 13 Feb 2021 18:10:29 +0100
Message-ID: <10903423.uF0vj5h9zV@sven-edge>
In-Reply-To: <20210213170204.3092113-1-bigeasy@linutronix.de>
References: <20210213170204.3092113-1-bigeasy@linutronix.de>

On Saturday, 13 February 2021 18:02:04 CET Sebastian Andrzej Siewior wrote:
> The usage of in_interrupt() in non-core code is phased out. Ideally the
> information of the calling context should be passed by the callers or the
> functions be split as appropriate.
> 
> The attempt to consolidate the code by passing an arguemnt or by
> distangling it failed due lack of knowledge about this driver and because
> the call chains are hard to follow.
> 
> As a stop gap use netif_rx_any_context() which invokes the correct code path
> depending on context and confines the in_interrupt() usage to core code.

Thanks, queued up

Kind regards,
	Sven

--nextPart13446814.T51Icr5x54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAoCAUACgkQXYcKB8Em
e0bBhA//W0Nb/44TEC40A1mfYoLCSlUnFKx5J2Qbs9/H/jmcoxSyoIVUUUlZTHPu
iF031fqfJostbGE6rwdV8cM9OQS6Mg7C3q+SUILgyAlKob1CKOoVhhkL9MdK+Y2n
yvGOaVYKn2o9CqKeXdGECEuA07+5Y8Hf0SFOnhLaHASUV9nwfr83wdC9C+VkWYvi
VfoslTkWBAh2Z7TweCMfXIxuJ6p9HA5glFRrbkTg6hxys/7PUtkX2CaWVM8TO7+k
RpfbGDjbx/uEdzPgyYR67WXE0mtgwUMV09HwiOvH9AzGEVYC7vj/+C/vM9kK6NIV
VIq8irMZ7i/IjwU2QHU7NIDaAsn1sP54NyYpPw6NnISxzwEAcG8eO5TZH3gaqjTv
bbftmCgOB4+qAiRWLMFp/eJX8c6FVUcpkJ56mqW436WwKSYKYS7aI3Uvi67WK4ps
T6+nx6ydNpXojaN3YGIgErsvEVF/UQjJ4vTMgcNJTSBVSd82o0q8GH3weVZw61vP
8lsoMRmGv0bYs9ph9J8CEZMXarh8gM2aZ35xio+LVbhYmMGsqjt3RCBEAB1nGehk
XhjiaAlM2bKbTHNZLxOF1bRXNeLMhJQRF2NJgV+CQo1ad3Wy3PsOfHsmxLsUD1pZ
CC3C6q7DgCklDO05iYKd4wUXeVesQrO6onLbQj+ZhCEeT1FV9c4=
=3HQw
-----END PGP SIGNATURE-----

--nextPart13446814.T51Icr5x54--


