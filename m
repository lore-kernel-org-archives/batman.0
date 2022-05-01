Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] alfred: notify event listener via unix socket
Date: Sun, 01 May 2022 11:10:13 +0200
Message-ID: <1831000.Ehg04xY5OU@rousseau>
In-Reply-To: <3246469.CvshgyVVUE@sven-l14>
References: <20220430105647.340588-1-mareklindner@neomailbox.ch>
 <3246469.CvshgyVVUE@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4033685.LUA7YngkGV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

 
--nextPart4033685.LUA7YngkGV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] alfred: notify event listener via unix socket
Date: Sun, 01 May 2022 11:10:13 +0200
Message-ID: <1831000.Ehg04xY5OU@rousseau>
In-Reply-To: <3246469.CvshgyVVUE@sven-l14>
References: <20220430105647.340588-1-mareklindner@neomailbox.ch> <3246469.CvshgyVVUE@sven-l14>

On Sunday, 1 May 2022 09:54:26 CEST Sven Eckelmann wrote:
> >  	printf("\n");
> >  	printf("server mode options:\n");
> >  	printf("  -i, --interface                     specify the interface 
(or
> >  	comma separated list of interfaces) to listen on\n");> 
> > @@ -164,6 +165,7 @@ static struct globals *alfred_init(int argc, char
> > *argv[])> 
> >  		{"change-interface",	required_argument,	NULL,	
'I'},
> >  		{"change-bat-iface",	required_argument,	NULL,	
'B'},
> >  		{"server-status",	required_argument,	NULL,	'S'},
> > 
> > +		{"event-monitor",	required_argument,	NULL,	'E'},
> 
> Why does it require an argument but the usage doesn't describe the argument?

Copy & paste error from server-status which does not require an argument 
either. Might need to fix in a separate patch.


> I am wondering now if it could be interesting for the listener whether the
> data is from us or some remote (for example via the source mac). Does anyone
> else have an opinion about that?

Currently, no use-case comes to my mind.


> > +static void unix_sock_event_listener_free(struct event_listener
> > *listener)
> > +{
> > +	list_del_init(&listener->list);
> > +	close(listener->fd);
> > +	free(listener);
> 
> list_del_init has no benefit (only downsides) when you free the memory
> anyway at the end of the function

What are those downsides you are referring to ?

Thanks for the review!

Kind regards,
Marek Lindner

--nextPart4033685.LUA7YngkGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmJuTnUACgkQU1VOj+62
HMCoCwf7Bnpx/gigx0kWVmV9vo8kZDtJgScWwY6usvc1F7ODM9FvDhj2gPwc5wFU
hPqPGYfXY7cSrxZ1ylNQH9ovYSy6GKocuu3WrIJv/dq9/hbzAgP/YIo1nIkgma3o
fgU9o8lGRzgsNQOsUVpn+uP97zPy2DM35ebE3AldoyHIL3PK4P/bWcsLVGnHXReh
oIRfR34F70o8FYmZZX2CvVusMrFAlOJRkcgFQ9j8q+ka8OBmMwjyuDYxbeVygcuF
SgQ+xF6OQxrmKi3g/Wp5sJeaTpMfypYI1DnNWIsVfRow5Nltc6dAHb6dmm9QSdzz
fDI3FABGzLZKJFxWn7+DNW4s8SFRkg==
=HVa3
-----END PGP SIGNATURE-----

--nextPart4033685.LUA7YngkGV--



