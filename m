Return-Path: <akinobu.mita@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130104021252.GE27589@ritirata.org>
References: <1357215562-6288-1-git-send-email-akinobu.mita@gmail.com>
 <1357215562-6288-20-git-send-email-akinobu.mita@gmail.com>
 <20130104021252.GE27589@ritirata.org>
Date: Fri, 4 Jan 2013 22:50:41 +0900
Message-ID: <CAC5umyhLB++mh=-pFRzhD-YxZH2RwC5ED4g8mYxS5pYGcbxsvw@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH -v2 19/26] batman-adv: rename random32()
	to prandom_u32()
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, akpm@linux-foundation.org, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>

2013/1/4 Antonio Quartulli <ordex@autistici.org>:
> On Thu, Jan 03, 2013 at 09:19:15PM +0900, Akinobu Mita wrote:
>> Use more preferable function name which implies using a pseudo-random
>> number generator.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Acked-by: Antonio Quartulli <ordex@autistici.org>
>> Cc: Marek Lindner <lindner_marek@yahoo.de>
>> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>> Cc: Antonio Quartulli <ordex@autistici.org>
>> Cc: b.a.t.m.a.n@lists.open-mesh.org
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: netdev@vger.kernel.org
>> ---
>
> Hello Akinobu,
>
> as you can see in <201301021952.49979.lindner_marek@yahoo.de>, Marek Lindner
> already applied this change onto our tree. You didn't need to resend this patch
> to netdev, it will be sent by us through a future pull request.

Yes. I read Marek's email. But I included it in v2 again in order not
to break the build. Because it doesn't show up the latest linux-next yet
and the last patch 26/26 removes random32() and srandom32().

But I should have mentioned it and trimmed the Cc list.
Sorry for the confusion.
