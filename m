Return-Path: <lindner_marek@yahoo.de>
Message-ID: <5077EE5F.8030601@yahoo.de>
Date: Fri, 12 Oct 2012 18:18:07 +0800
From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
 <5077A77B.3040803@altermundi.net> <20121012071559.GB2564@ritirata.org>
In-Reply-To: <20121012071559.GB2564@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 10/12/2012 03:15 PM, Antonio Quartulli wrote:
> The behaviour is correct: OGMs are broadcast packets. In infrastructure mode,
> whatever broadcast packet a station sends gets to the AP which will re-broadcast
> it again. In this way every station gets it and from the batman-adv point of
> view it is like the packet was received directly from the other sta (the MAC
> addresses in the packet say so). Therefore you must enable ap-isolation in
> hostapd if you want batman-adv to behave as you expect.

I'd like to stress the point that batman-adv is not "confused" as you 
describe it in your blog post. Antonio explained it already: In 
infrastructure mode all station _are_ neighbors.

Cheers,
Marek
