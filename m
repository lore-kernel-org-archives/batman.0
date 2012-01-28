Return-Path: <ordex@autistici.org>
Date: Sat, 28 Jan 2012 15:12:57 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120128141253.GF15766@ritirata.org>
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127151914.GB19664@lunn.ch>
	<201201272354.26055.lindner_marek@yahoo.de>
	<20120127191334.GF27169@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20120127191334.GF27169@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
 shorter routes by changing the default hop penalty
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>

Hi all,

Very nice setup Andrew :)

On Fri, Jan 27, 2012 at 08:13:34 +0100, Andrew Lunn wrote:
> > So, you had to reduce the default value of 10 to something even smaller ? A 
> > hop penalty of 10 results in a penatly of 4% per hop. A rough equivalent of 2 
> > lost packets (62/64). Does not sound very much to me. Can you explain your 
> > test setup a little more ?
> 
> I suspect the TQ measurements as determined by OGMs are more
> optimistic than actual data packets. Linus's played with different NDP
> packet sizes, and i think he ended up with big packets in order to
> give more realistic TQ measurements.
> 
> > Nevertheless, this patch was intended to get a discussion going. 
> 
> Well, i'm happy to take part in the discussion. I've no idea if our
> use case is typical, or an edge case. So comments, and results from
> other peoples networks would be useful.
> 
> If this change it to help 11n, maybe some more intelligence would be
> better, to ask the wireless stack is the interface abg or n, and from
> that determine what hop penalty should be used?


In my honest opinion we are mixing two different issues:
1) current hop penalty value not really significant
2) OGM link quality measurements do not reflect the metric we'd like it to be


problem 2 is not going to be solved by hacking the hop penalty. It needs further
investigation/research and NDP is probably a good starting point towards a
possible solution (I think we all agree on this).


For what concern the hop penalty, as far as I understood, it is in charge of
making batman prefer a shorter route in case of equal TQs over the traversed
links. Instead of hacking the value...what about redesigning the way the hop
penalty affects the TQ value of forwarded OGMs? Maybe using a different
function (poly of deg>1 or exp) instead of a simple linear decreasing? May this
help all the scenarios we mentioned? 


Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
