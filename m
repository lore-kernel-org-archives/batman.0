From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 6 Aug 2008 15:54:13 +0800
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_liVmIWIdPw/rzz/"
Message-Id: <200808061554.13830.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Fwd: Re: A few comments on the BATMAN routing
	protocol
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
To: b.a.t.m.a.n@open-mesh.net, olsr-users@lists.olsr.org

--Boundary-00=_liVmIWIdPw/rzz/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Forgot the lists ...


Marek

--Boundary-00=_liVmIWIdPw/rzz/
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Marek Lindner <lindner_marek@yahoo.de>: Re: A few
	comments on the BATMAN routing protocol
Content-Disposition: inline

From: Marek Lindner <lindner_marek@yahoo.de>
To: "Elektra Elektra" <onelektra@gmx.net>
Subject: Re: A few comments on the BATMAN routing protocol
Date: Wed, 6 Aug 2008 15:05:06 +0800
User-Agent: KMail/1.9.9
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	siwu@hrz.tu-chemnitz.de, elektra@open-mesh.net, axel@open-mesh.net,
	roman@steinerweb.at, aaron@lo-res.org
References: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
	<20080805224350.297370@gmx.net>
In-Reply-To: <20080805224350.297370@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808061505.06833.lindner_marek@yahoo.de>


Hi,

> thank you for your profound analysis! 

many thanks ! We are very happy to see that our ideas encourage people to 
spend more time on thinking it through. We appreciate all kind of feedback.
Although, I suggest to get in touch with the BATMAN developers earlier next 
time. We can answer questions much better and can comment on current 
development more precise than outsiders.

I agree to most of comments made by elektra. I want to add only a few more 
insights:


> > 2. BATMAN does not contain any loop avoidance mechanisms; in the
> >    presence of so-called ``optimistic routing'', BATMAN may exhibit
> >    persistent routing loops.  Even without optimistic routing, BATMAN
> >    will exhibit transitory routing loops.
>
> In your example the route loops because the destination doesn't exist
> anymore, so there won't be any updates from this originator, hence the
> protocol may loop. I don't think that hurts much, because a looping route
> to a non-existing node is IMHO a minor problem. OK - we have some extra
> avoidable traffic in the network, that could have been avoided otherwise.
> So checking whether we forward exactly the same payload packet again and
> again with decremented TTL might be a good thing to add to the protocol.

The payload transport is not handled by BATMAN which "only" manipulates the 
routing table. This is handled by other mechanisms and protocols. TTL is one 
way to achieve that, that is why TCP & Co have them. No need to reinvent the 
wheel.
I think it is a good sign that you only found a loop towards a non-existent 
host. Other protocols should learn from us.  ;-)


> > 3. The metric used by BATMAN is not realistic, and  will cause it to
> > favour asymmetric links taken ``the wrong way''.

This is a known issue and has been publicly discussed since 09.01.2007:
https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2007-January/000010.html

As mentionned by Elektra we already have a solution.

Keep up the good work,
Marek



--Boundary-00=_liVmIWIdPw/rzz/--
