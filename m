Return-Path: <bug-track@fisher-privat.net>
Message-ID: <4EC0EB27.8060207@fisher-privat.net>
Date: Mon, 14 Nov 2011 11:19:19 +0100
From: Alexey Fisher <bug-track@fisher-privat.net>
MIME-Version: 1.0
References: <1321261892-6401-1-git-send-email-bug-track@fisher-privat.net>
	<9935980.KTPM4GpO8u@sven-laptop.home.narfation.org>
In-Reply-To: <9935980.KTPM4GpO8u@sven-laptop.home.narfation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] add make install
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

On 14.11.2011 10:38, Sven Eckelmann wrote:
> On Monday 14 November 2011 10:11:32 Alexey Fisher wrote:
>> Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
>> ---
>>  Makefile |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 5762721..44bad88 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -42,3 +42,6 @@ all:
>>
>>  clean:
>>  	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
>> +
>> +install:
>> +	@cp batman-adv.ko $(shell dirname
>> $(KERNELPATH))/kernel/net/batman-adv/batman-adv.ko
> 
> NAck: Sven Eckelmann <sven@narfation.org>
> 
> Please read in the current linux sources Documentation/kbuild/modules.txt
> 
> +install
> +	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) modules_install
> 
> or to override the old version that is included in the kernel
> 
> +install
> +	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install

Thank you,
so you will send your patch? I prefer last version, to make testing easier.

regards,
Alexey.

