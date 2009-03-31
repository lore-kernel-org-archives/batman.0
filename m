MIME-Version: 1.0
In-Reply-To: <200904010215.44621.lindner_marek@yahoo.de>
References: <49D2300C.9010206@kait.de>
	<200904010215.44621.lindner_marek@yahoo.de>
Date: Tue, 31 Mar 2009 21:13:01 +0200
Message-ID: <5b8543210903311213n139e4323pa5e879c53fb42f04@mail.gmail.com>
From: Kai Timmer <email@kait.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv nodes do not recieve OGMs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

2009/3/31 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> the same problem when trying the svn version 1241.
>
> please don't use the trunk for batman-adv as it has a serious bug that
> requires fixing.

Ok :)

>> Adding interface: ath0
>> Can't activate module: the primary interface is not active
>
> I think this message gives you a pretty good idea of what the problem might
> be. I guess your interface ath0 is not up & running. Try an "ifconfig ath0 up".
> :-)

Actually i already tried that and it didn't change anything. And when
that is really the problem, why is the module than even starting to
send messages?

Greets,
-- 
Kai Timmer
Email : email@kait.de
Jabber: kai@kait.de
Blog: http://blog.kaitimmer.de
