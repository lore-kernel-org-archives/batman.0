Return-Path: <br1@einfach.org>
Message-ID: <5163D7ED.3030204@einfach.org>
Date: Tue, 09 Apr 2013 09:57:17 +0100
From: Bruno Randolf <br1@einfach.org>
MIME-Version: 1.0
References: <516398DB.3070108@wirelesspt.net>
 <20130409062848.GA3624@ritirata.org>
In-Reply-To: <20130409062848.GA3624@ritirata.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] horst and batman-adv
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 04/09/2013 07:28 AM, Antonio Quartulli wrote:
> On Tue, Apr 09, 2013 at 12:28:11AM -0400, cmsv wrote:
>> I found about Horst a few years ago when i got to know olsr and it's
>> usefulness for olsr mesh networks and recently decided to check it out
>> again.
>> Although i do see an option for batman i am not sure if it refers to
>> batmand or batman-adv and as i wait for an answer from it's developer.
>>
>> My question is if there are any plans for a similar tool from open-mesh
>> side.
>> I am also curious to know if someone is using it with batman-adv or
>> anything equivalent/similar or close ?
>> What are our options.
>>
>> http://br1.einfach.org/tech/horst/
>
> Hello cmsv,
>
> I've used it once, but without any interaction with batman-adv or olsr.
> I just looked for the pollution in the channels.
>
> How is it supposed to interact with the protocol?

Hello!

I'm the author of "horst". There is not much interaction with the 
protocol, except that the packets are marked as such, e.g. nodes which 
send OLSR packets are marked as OLSR nodes, nodes which send batman (L3) 
messages marked as batman nodes. It's quite easy to add the same for 
batman-adv, but it's not there at the moment.

bruno

