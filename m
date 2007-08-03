Message-ID: <20070803110942.7h6ynax7lx0cckgc@webmail.ddmesh.de>
Date: Fri, 03 Aug 2007 11:09:42 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] dynamic gateway
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zitat von Marek Lindner <lindner_marek@yahoo.de>:

>
> Hi,
>
>
> this question was a bit forgotten.  :-)
>
>> how does batmand detect whether the internet connection is really connected
>> to the internet or not. Or does batmand just relays on the -g parameter.
>> Until now we let run a cron job that checks for the real working
>> gateway. Because we can not relay on the presence of the default
>> route. User may use a different
>> router to connect to the internet and just add the default route this
>> private router.
>> The problem is that the node offering a internet connection (-g)
>> should also be able to access other internet connection if its local
>> connection is brocken.
>
> First of all, "-g" is just flooded through the network. We also want  
>   some kind
> of "dyngw"-plugin but with a better approach: By using tunnels to the gateway
> batman is in a far better situation than OLSR. The "is internet really
> available" check can be done on the client side and is therefore much more
> reliable. With batman 0.3 all the packet flow towards and from the internet
> is going through batman. Batman just has to check whether traffic is coming
> back through the tunnel after sending packets to the internet. If this is not
> the case the batman node offering the internet is blacklisted and another
> gateway is chosen.
> This has not been implemented yet but all the neccessary basics for that
> feature are completed by now. Expect this feature to come in the following
> weeks.
>
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

this sounds good, but you should keep in mind that such a "good"
internet connection that was choosen being the best, has only a short
disconnection. I this case each batmand of each client should retest
the connection after a timeout of few minutes. I think this could be
disturbing an established connection because the batmand has to change
the tunnel to the new gateway.
For this I beleave that it is better to have a separated process
checking its own internet connection (if provided and setup by node
config). this process then tells batmand about the connection. batmand
will deside on some criteries if this connection is stable an worth to
be populated through the net.
I have implemented in our firmware a test (like leipzig) that only
pings some addresses.

cheers
  Stephan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)

iD8DBQFGsjy+ZSvvlmZMBPIRAuCNAJ0WFVjL92oCAQtCiZxpCPPMaeEMrQCfdQ9S
sNv9gTDx0pk5yMNheTEMkAE=
=oLrN
-----END PGP SIGNATURE-----




