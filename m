From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] maybe some reason
Date: Mon, 18 Jun 2007 15:43:53 +0200
References: <1D2535A1-F70E-46F3-B24F-A12C33DCC097@port-x.de>
In-Reply-To: <1D2535A1-F70E-46F3-B24F-A12C33DCC097@port-x.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706181543.53498.lindner_marek@yahoo.de>
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

> i'think about some smal tool ... or batmand have this option to
> update himself. for example the option batmand -vn,  he look every day
> for a new stable version ... or some seperat tool ... what can update
> a lot nodes ... to do this bei manual is grrrr ....
>
> it's only some idea.

an integrated auto-update mechanism is difficult because we have many batman 
users outside of Germany. Should they all update via open-mesh ? On the other 
hand may be they don't want to have the latest version because they are happy 
with what they have. Or they want to test it before the whole network 
updates.
I better solution would be a custom skript which checks for updates and logs 
into the router via SSH to install it. Axel wrote such a script. I think he 
could give it to you.
Is it worth considering to publish it on open-mesh ?


> so, some other info ... the batman net run here nice ... only the
> gatway get a lot of cpu work ... sometimes it's grow up
> to 80% ... but it's working. i'wait for the version what made the
> routing on layer 2 ... and  i'will fast roll out it.

I hope you take some time to test it before you that or your users may become 
unhappy.  ;-)

Regards,
Marek
