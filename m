From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
Date: Fri, 15 Feb 2008 19:27:34 +0100
References: <20080214211549.cw83me7cwg8w44cw@webmail.ddmesh.de>
In-Reply-To: <20080214211549.cw83me7cwg8w44cw@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802151927.34778.axel@open-mesh.net>
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

Hi Stephan,

can you check if rv980 solves the problem ?

ciao,
axel

On Donnerstag 14 Februar 2008, Freifunk Dresden wrote:
> Hi Axel,
>
> I have done some checks. First I have added the tincd tap interface to
> a bridge and used the bridge as parameter for batmand. This is currently
> running since 10h.
>
> The second what I have tried is to call "kill -STOP $(pidof tincd)".
> On the WRT54GL batmand stopped quite fast, but it stopped also fast without
> the "kill". On the WRT54SL where I never have seen batmand stopping, the
> "kill" has stopped batmand after 5-10 minutes. I could reproduce this
> serveral times with the GS.
>
> When calling batmand -c -a 120.56.56.56/32 I get the following output on
> batmand -cd3:
>
> [    275531] Unix socket: got connection
> [    275539] got request: 10
> [    275540] Unix socket: Requesting adding of HNA 120.56.56.34/32 -
> put this on todo list...
> [    275544] got request: 10
> [    275545] Unix client closed connection ...
>
> Three batmand processes are running and batmand -c returns:
> WARNING: You are using BatMan-eXp 0.3-alpha (compatibility version 10) !
> /sbin/batmand [not-all-options-displayed] -r 2 -a 10.12.10.16/28 eth1 tbb
>
> After calling "killall batmand" only one of three batmand processes is
> killed. I have to killall -9 to get rid of it.
>
> Regards
> /Stephan
>
>
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


