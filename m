Return-Path: <felix@kaechele.ca>
Message-ID: <bf02aeff-210c-a5e0-47d7-c5b276c9b794@kaechele.ca>
Date: Sat, 16 Apr 2022 10:01:25 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] batman-adv: Don't skb_split skbuffs with frag_list
Content-Language: en-US
References: <20220416122434.33061-1-sven@narfation.org>
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <20220416122434.33061-1-sven@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi there,

initial testing shows that this patch seems to fix the issue.
We are currently at 30 minutes of uptime on our fairly busy mesh which 
is already 15-30 times better than before.

Thanks for the super quick turnaround on this one, especially on easter 
weekend.

I will report back after some more uptime, but I have a feeling that if 
it is working right now it will probably continue to function just fine.

Thanks again!

Regards,
Felix
