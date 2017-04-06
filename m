Return-Path: <xbing6@gmail.com>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
 <1626579.VOjpoqf3Fa@prime> <2383073.8lvV2lGcs0@bentobox>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <56f44583-9cbc-d3eb-20c2-b8243a7889a1@gmail.com>
Date: Thu, 6 Apr 2017 16:05:26 +0800
MIME-Version: 1.0
In-Reply-To: <2383073.8lvV2lGcs0@bentobox>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven, Simon,

Thank you very much for your help. These 2 patches are not merged 
upstream? I did see a similar patch merged (as you 2 are the authors, 
you know it very well):
 > [1] https://patchwork.kernel.org/patch/9433619/
 > [2] https://patchwork.kernel.org/patch/9433621/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a34d0a0da1abae46a5f6ebd06fb0ec484ca099d9

Thanks again.
xuebing

On 2017年04月06日 15:13, Sven Eckelmann wrote:
> On Donnerstag, 6. April 2017 09:04:50 CEST Simon Wunderlich wrote:
>> Hello Xuebing,
>>
>> it sounds like you have WiFi driver issues. There are some effects like key
>> cache corruption, deafness, and other effects known for the AR93xx series.
> Correct, completely forgot about the deaf and 0xdeadbeef issues. There were
> also two workarounds for them [1,2] from Simon.
>
> Kind regards,
> 	Sven
>
> [1] https://patchwork.kernel.org/patch/9433619/
> [2] https://patchwork.kernel.org/patch/9433621/

