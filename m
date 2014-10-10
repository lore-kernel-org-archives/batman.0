Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 10 Oct 2014 20:54:44 +0200
Message-ID: <2593620.VKXIbnOaZg@prime>
In-Reply-To: <20141006210421.GA11864@makrotopia.org>
References: <53FDD9D1.9080303@rund.freifunk.net> <1461254.rz0spk34lf@prime>
 <20141006210421.GA11864@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4318326.v8qVde6DHF";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] new alfred packet type *3* for solar tracer
	charging units
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart4318326.v8qVde6DHF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 06 October 2014 23:04:28 Daniel Golle wrote:
> On Mon, Oct 06, 2014 at 04:39:15PM +0200, Simon Wunderlich wrote:
> > > so the next step should be to include these into alfred?
> > 
> > We basically have two options here:
> >  * integrat the tracetools into the alfred repository, similar to vis and
> > 
> > gpsd. Please note that the quality should also be similar and you or your
> > colleagues should be able to maintain that code
> > 
> >  * keep the package external (e.g. on gitorious), then since we have an
> > 
> > external software package now we should start using a number assignment
> > table in wiki to show which software uses which packet type. We could
> > then link from there your software
> > 
> > Any preferences? :)
> 
> I will definitely keep tracertools a standalone software package as there
> are many potential use-cases which do not involve alfred.
> Basically I'm still in the prototyping progress of a bigger system in,
> tracertools was a part of that effort. Now that other things (using PCF8574A
> and LTC4151 to monitor and control consumer-grade DC-to-AC inverters via
> I2C) also work, I will re-work the whole design, both, in terms of hardware
> I will move away from breadboard and loose wires to a proper shield
> targetting the WrtNode; in terms of software, tracertools will become a
> small lib and include handling serial port stuff instead of depending on
> socat to do that (though using socat has a couple of advantages as well and
> I may keep the option to pipe stuff through socat).
> Packages like collectd and alfred can then use libsolartracer to acquire
> (cached) stats or execute control commands on the charge controller, similar
> to how libgps is used by alfred.
> I'm planning to suggest a patch to alfred to optionally use libsolartracer
> when the time has come for that...

OK, so at some point you'll probably write an alfred patch which goes into our 
repo and will make use of  your library? That sounds like a good approach to 
me ... :)

Thank you very much for the feedback, please keep us posted on your 
proceedings!!

Thanks,
    Simon
--nextPart4318326.v8qVde6DHF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlQ4K3QACgkQrzg/fFk7axa2MACgvWZw9rL6BR3yxoj/6R6knSNy
chEAn0Y1D7PjxQTJWgLvHyACCVv/Qp9q
=RLA6
-----END PGP SIGNATURE-----

--nextPart4318326.v8qVde6DHF--

