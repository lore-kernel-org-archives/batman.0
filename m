Return-Path: <gui@altermundi.net>
Message-ID: <51C91911.9000506@altermundi.net>
Date: Tue, 25 Jun 2013 01:14:09 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <51C76DDE.20903@altermundi.net> <51C77678.1040904@altermundi.net>
 <20130624070245.GI1124@ritirata.org>
In-Reply-To: <20130624070245.GI1124@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Possible bad interaction between BLA2 and TT?
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
Cc: Antonio Quartulli <ordex@autistici.org>

On 06/24/2013 04:02 AM, Antonio Quartulli wrote:
> On Sun, Jun 23, 2013 at 07:28:08PM -0300, Gui Iribarren wrote:
>> On 06/23/2013 06:51 PM, Gui Iribarren wrote:
>>>
>>> the "gap" in labanda-oeste is between seq=73 and seq=89
>>> in labanda-oeste there were no messages or traffic for 25secs, and then
>>> the "TT inconsistency" came up, resolved, and seq=89 succeded, traffic
>>> restored.
>>> at that time, seq=74, labanda-este got a TT update:
>>> [  23161800] Deleting tdorado from global tt entry 44:d8:84:b0:d2:f5: tt
>>> removed by changes
>>> and (AFAIU) dropped traffic coming from labanda-oeste until
>>> labanda-oeste finally got the TT update and increased the ttvn to 129
>
> As we clarified on IRC, BLA2 is not involved at all.
>  From what I can see I'd say that a node in the middle is dropping the traffic
> due to a wrong re-routing operation. if you could reproduce the issue, it would
> be nice if you could get the tt log on all the nodes along the path.
> In this way we can clearly see who is doing what.

(11:58:09 AM) gui_: ah, ordex, btw, there's no "in the middle" :(
(11:58:29 AM) ordex: what do you mean?
(11:58:41 AM) ordex: does it happen with two nodes only?
(11:58:44 AM) gui_: labanda-este is a direct neighbor of tdorado
(11:58:49 AM) gui_: i mean the path is
(11:58:53 AM) gui_: oeste -> este -> tdorado

And, finally, to throw some spice into the mix, i downgraded 
kmod-batman-adv just in labanda-este (my key suspect) twice, and...
i can reproduce this issue with 3.8.3+2013.2.0-2 and 3.8.3+2013.1.0-3
but not with 3.8.3+2012.4.0-1

both labanda-oeste and tdorado are still running 2013.2.0. Downgrading 
labanda-este to 2012.4.0 was enough to solve the issue.

so it looks like a regression introduced between 2012.4.0 and 2013.1.0

yet, it is pretty obscure to me what is actually happening, (and why 
only in this scenario) so i'll try to get some dumps as promised, but 
since my current internet connection depends on this link, i was a bit 
in a hurry to get it back to stable :P

Cheers!

Gui
