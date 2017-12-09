Return-Path: <carlitonueno@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2688443.brWePDBBRx@sven-edge>
References: <CAEUauspRyThs6WLqp3E2=7pHG=emT9F9eckfEWsBUwvnktaiPQ@mail.gmail.com>
 <2688443.brWePDBBRx@sven-edge>
From: Carlito Nueno <carlitonueno@gmail.com>
Date: Sat, 9 Dec 2017 14:12:32 -0800
Message-ID: <CAEUausq3GtSMxkG6ct5Ep5=LXhu0d1Pr07yOq2dN4xwJgqF6og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] Set preferred mesh backhaul link
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Thanks Sven for a detailed reply.

I read about batman and tried to understand it's source. Like you
said, we are not going to use 2.4GHz with batman-adv.

Yes, 5GHz is highest throughput and hence the reason for using it as
mesh backhaul. For now, batman IV is stable on QCA 9880 ath10k.

I'll try to get in touch with QCA and see if I can help in this process.

On Thu, Nov 2, 2017 at 2:16 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Mittwoch, 1. November 2017 20:07:52 CET Carlito Nueno wrote:
>> Hi,
>>
>> I have two access points with 2.4GHz and 5GHz radios.
>>
>> Node A and Node B
>>
>> Both radios are mesh via batman-adv. I can see them with batctl if.
>>
>> Node A is server - batctl gw server
>> Node B is client
>>
>> So here is my problem:
>
> Just a small remark here: The batctl gateway feature [1] is not relevant for
> the routing decisions. You have to look at `batctl o` to get some information
> about the available originators and their link qualities and `batctl tl`/
> `batctl tg` to find which client mac address is associated with which
> originator.
>
>
>> When I check batctl gwl, it shows that it uses Node A's 2.4GHz
>> interface. How can I set it so that it prefers 5GHz as mesh backhaul?
>
> There is no official way to do that when you we assume that both interfaces
> have the same transmission quality (TQ) and you are using the default
> (B.A.T.M.A.N. IV) routing algorithm.
>
> In B.A.T.M.A.N. IV you could modify batadv_iv_ogm_calc_tq() to apply an extra
> penalty for the 2.4GHz link. For example by changing the line
> "batadv_ogm_packet->tq = combined_tq;" to something more like:
>
>     if (if_incoming is 2.4GHz)
>         /* apply 25% penalty -> keep only 75% of original tq -> 192 / 255 */
>         batadv_ogm_packet->tq = (combined_tq * 192) / BATADV_TQ_MAX_VALUE;
>     else
>         batadv_ogm_packet->tq = combined_tq;
>
> I don't know exactly what your goal is but your question could also be
> interpreted as "we don't want that 2.4GHz is used". In this case, please don't
> add the 2.4GHz interface to your batman-adv interface. But I would guess that
> you don't want to do that for another reason.
>
>
> The other option would be to test B.A.T.M.A.N. V (which is not the default and
> considered experimental). In theory, B.A.T.M.A.N. V should automatically
> choose the link with the highest expected throughput (check `iw dev XXXX
> station dump` for the expected throughput towards a neighbor). I would guess
> that the 5GHz link is in your case the one with the highest throughput (but
> with roughly the same packet loss), right? And this is also the reason why
> you want to use it, correct?
>
> But there is often ran into problems when you try to use current 802.11ac
> hardware with B.A.T.M.A.N. V. The closed source firmware of these chips
> doesn't export the expected throughput. Problem here is that the rate control
> algorithm has all the information to calculate it but the rate control
> algorithm is often hidden in this closed source firmware. Hence, the open
> source driver cannot export via cfg80211 to other components (like batman-adv
> or to iw & oonf via nl80211).
>
> A prominent example here is QCA with ath10k. We've already tried to get in
> contact with their current open source team manager. But unfortunately, he
> doesn't even understand what expected throughput is and why we need it. So if
> there are other persons out there which have the same problem, maybe they can
> also try to get in contact with QCA to get this problem solved.
>
> Kind regards,
>         Sven
>
> [1] https://www.open-mesh.org/projects/batman-adv/wiki/Gateways
