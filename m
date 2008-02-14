From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
Date: Thu, 14 Feb 2008 10:19:09 +0100
References: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
	<200802122034.21957.axel@open-mesh.net>
	<20080213174817.nutikha74k88ko8o@webmail.ddmesh.de>
In-Reply-To: <20080213174817.nutikha74k88ko8o@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802141019.09822.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

>
> > The strange thing is that the debug-level-4 output stops in the middle of
> > an action. Can you also check for the number of batmand processes before
> > and after the stopped batmand process?
>
> The number of task are the same.
> But I have seen, that when the -d4 output stopps and I keep this
> batmand running
> when accessing an different log level from another terminal, I see the
> socket-connection logs in -d4 output.
>
> Also I still can just call "batmand -c" to see the parameters and
> current gateway settings. I also can change the gateway settings.
>
> The batmand seems to stop processing any OGMs.

The messages you see are logged from another thread (not the thread which is 
doing the OGM processing). Thats also the reason why some of the dynamically 
changeable parameters _seem_ to be processed. I guess for example a
"batmand -c -a 1.2.3.4/32" wont be processed completely.
In this case a simultaneous running "batmand -cd3" _should_ report:
[    162940] Unix socket: got connection
[    162946] got request: 10
[    162947] Unix socket: Requesting adding of HNA 1.2.3.4/32 - put this on 
todo list...
[    162951] got request: 10
[    162952] Unix client closed connection ...
[    163157] found todo item, adding HNA 1.2.3.4/32 atype 1

I guess everything except the last line will be shown. The last line is 
generated from the OGM-processing thread which seems to be blocked.

Perhaps, if you can find a way to reliable reproduce this kind of problem then 
it would be much easier to fix it. Just an idea, what happens with batmand 
(bound to the tap interface) when stopping the running tincd like this:  
kill -STOP $(pidof tincd)
and later on:
kill -CONT $(pidof tincd)

ciao,
axel
>
>
> > Have you ever tried what happens if you connect the tap interface to a
> > bridge and bind batmand to the bridge device instead?
>
> I haven't tried it, yet. but this also came in my mind. I will this
> check after
> finishing the "no-tap-dev-test"
>
> > Last but not least: have you observed (or explicitly not observed) this
> > phenomenon also with previous revisions in the same scenario ?
>
> I can not say, because implementing tinc and updateing the batmand
> version was at same time.
>
> >> I never have seen this problem with the WRT54GS, only with GL.
> >
> > Is the batmand on the WRT54GS also bound to a tinc interface ?
>
> Yes, the GL is running standalone with stubid tincsetup and also the
> GS was running with same parameters and standalone (no network cable).
>
> Perhaps it is more random and is depending on speed of the router when the
> event occurs.
>
> bye Stephan
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


