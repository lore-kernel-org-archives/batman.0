Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Aug 2018 11:02:54 +0200
Message-ID: <2057936.2F7DdePauk@sven-edge>
In-Reply-To: <314bf0ac-4c10-da7a-d527-45afe92423fa@unstable.cc>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <8211925.JcgYpGFXDF@sven-edge>
 <314bf0ac-4c10-da7a-d527-45afe92423fa@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13453119.uG2vYbrkmh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org

--nextPart13453119.uG2vYbrkmh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 4. August 2018 10:41:09 CEST Antonio Quartulli wrote:
[...]
> >>  Documentation/ABI/testing/sysfs-class-net-batman-adv | 7 +++++++
> > 
> > Please discuss this with Jiri [1].
> > 
> 
> After re-reading Jiri's points I can't really understand why we should
> now switch to netlink. I think all our sysfs knobs are used to inject
> settings *to* userspace, therefore his point 1) does not really apply to
> us. Point 2) is a bit generic and does not really explain why we should
> *switch*.

Wouldn't it have been better when Jiri would also see your reply? Now he isn't 
even aware of your criticism.

> This said, I'd rather keep this patch as it is and possibly discuss the
> matter when sending this code to netdev for merging.
> 
> I've discussed this with Marek too and he is fine with this approach.

Interesting, I don't see it this way. This patch [0] is for netdev and we have 
the statement that "usage of sysfs in netdev subsystem is frowned upon". Now 
you want that we ignore that and than maybe Simon have to deal with the 
fallout when he forwards it to David?

Kind regards,
	Sven

[0] https://patchwork.open-mesh.org/patch/17372/

> > [1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-May/017814.html
--nextPart13453119.uG2vYbrkmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltla74ACgkQXYcKB8Em
e0YV7hAAhyg76iFvp1QxsuqfTDeJH14xCaXy3CxBK1lFjiakSLmdpTMIUaPAITmR
gNX5l1eG3+VTN7JEOYXlXqxnHUbplT7cDjVy3b3XBZ+Chk4EUZH6RFFUcrapSV3S
h5ApaBRzM5hcPFb9pBSLwx5bNwF9CgWwvYPU2trPXW35D/iHbLX0bq4neOxOVOy5
Y3lUzuFfzCnlDTs0pd3BYS4M4OYepUKipeOKfn7LAj4b+4kCkRxg9I/Ka4+m0ErH
t7fI8G3rODIC5VfNkoXhMBrSXarVxeFkIWqstnQcNHecM1dMMdd/ixAU12DwFMSb
+pO/C2Q8rtliWjQEMBK5ntKqRHLcupUUq7yr3TNAzLfKoVu37otNs46+QsphHbWU
BLaM0KWks9mGXC5C2IzFOQW2t+k+8r/+3rqhlvySkGryJkM1lbncOqKckEqTdCPe
ohskH4fhUcy5H3XR+0P5UIbeJPZ2XdQ1eaihUPcDn9pbLTJ0+29QCcoNOKlSNRU+
9spfXOZuZmq+tonDhDFJJydpHqbXyiwbM8HsOqnqeELfIpg1eB/P/EpTyH9bUQpu
v1sL0hNm3gmN6sFfUadFiTvk374etZIUcjfsW2W2sX/64owxDg1Ic+ofEyvqD3Y+
oCyo0+0dzZ9qO4rhmB+zSulPpJOUp3O3oFdfsNJAjmjoIk10Vk4=
=bWKz
-----END PGP SIGNATURE-----

--nextPart13453119.uG2vYbrkmh--



