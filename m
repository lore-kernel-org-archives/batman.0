Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <50C4B63F.60101@web.de>
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
 <CAHD-aqLUc7YAsmgOdGS2nxdU06U3KTbCAtjXHa4v_64fzHNhWg@mail.gmail.com>
 <50C471C0.2060407@web.de> <201212092231.50649.lindner_marek@yahoo.de>
 <50C4B63F.60101@web.de>
From: Gui Iribarren <gui@altermundi.net>
Date: Sun, 9 Dec 2012 13:35:31 -0300
Message-ID: <CAHD-aqJ9vCqHBSa53zDvWvAr1hJnqqjr_Jxj0YEtV4BCFkuu+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
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

Didn't test it but gave a quick glance, looks good to me :)

I'd also add 'netifd' as a dependency in the makefile

(and, well, increase the pkg revision, but that's marek job)

Thanks a lot!

On Sun, Dec 9, 2012 at 1:03 PM, Moritz Warning <moritzwarning@web.de> wrote:
> Here you go. :)
> It would be good idea if Gui had a look at it before it is applied.
>
> On 12/09/2012 03:31 PM, Marek Lindner wrote:
>> On Sunday, December 09, 2012 19:10:56 Moritz Warning wrote:
>>> I have tried batman-adv-netifd-proto-batadv.patch along with some Makefile
>>> adjustments to get it compile. Afaict it works.
>> Thanks for testing! Do you mind sharing & explaining these changes ? Would be
>> a good idea to push the working variant, don't you think ?
>>
>> Cheers,
>> Marek
>>
>
