Message-ID: <5635aa0d0901131100n16930445ud46e315558b40e06@mail.gmail.com>
Date: Wed, 14 Jan 2009 02:00:32 +0700
From: "Outback Dingo" <outbackdingo@gmail.com>
In-Reply-To: <1231872376-21395-2-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_54103_12323306.1231873232948"
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
	<1231872376-21395-2-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Fix compilation on freebsd
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

------=_Part_54103_12323306.1231873232948
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Very COOL...!!

On Wed, Jan 14, 2009 at 1:46 AM, Sven Eckelmann <sven.eckelmann@gmx.de>wrote:

> FreeBSD doesn't include as much deep includes in their socket headers
> as the linux ones does. To support building on freebsd we must include
> them explicit.
>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> CC: Antoine van Gelder <antoine@7degrees.co.za>
> ---
>  vis-advanced/vis.c |    2 +-
>  vis-advanced/vis.h |    2 ++
>  vis/vis.c          |    2 +-
>  vis/vis.h          |    2 ++
>  4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/vis-advanced/vis.c b/vis-advanced/vis.c
> index 721d690..69f69b8 100644
> --- a/vis-advanced/vis.c
> +++ b/vis-advanced/vis.c
> @@ -23,10 +23,10 @@
>
>
>  #include <fcntl.h>
> +#include <sys/socket.h>
>  #include <net/if.h>
>  #include <sys/ioctl.h>
>  #include <sys/select.h>
> -#include <sys/time.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> diff --git a/vis-advanced/vis.h b/vis-advanced/vis.h
> index 6f6793e..a060c83 100644
> --- a/vis-advanced/vis.h
> +++ b/vis-advanced/vis.h
> @@ -25,6 +25,8 @@
>  #include <pthread.h>
>  #include <sys/socket.h>
>  #include <sys/types.h>
> +#include <sys/time.h>
> +#include <netinet/in.h>
>  #include <arpa/inet.h>
>  #include <errno.h>
>
> diff --git a/vis/vis.c b/vis/vis.c
> index 05f4096..c488365 100644
> --- a/vis/vis.c
> +++ b/vis/vis.c
> @@ -23,10 +23,10 @@
>
>
>  #include <fcntl.h>
> +#include <sys/socket.h>
>  #include <net/if.h>
>  #include <sys/ioctl.h>
>  #include <sys/select.h>
> -#include <sys/time.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> diff --git a/vis/vis.h b/vis/vis.h
> index 8953b70..1f343d8 100644
> --- a/vis/vis.h
> +++ b/vis/vis.h
> @@ -25,7 +25,9 @@
>  #include <pthread.h>
>  #include <sys/socket.h>
>  #include <sys/types.h>
> +#include <sys/time.h>
>  #include <arpa/inet.h>
> +#include <netinet/in.h>
>  #include <errno.h>
>
>
> --
> 1.6.0.6
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_54103_12323306.1231873232948
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Very COOL...!!<br><br><div class="gmail_quote">On Wed, Jan 14, 2009 at 1:46 AM, Sven Eckelmann <span dir="ltr">&lt;<a href="mailto:sven.eckelmann@gmx.de">sven.eckelmann@gmx.de</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
FreeBSD doesn&#39;t include as much deep includes in their socket headers<br>
as the linux ones does. To support building on freebsd we must include<br>
them explicit.<br>
<br>
Signed-off-by: Sven Eckelmann &lt;<a href="mailto:sven.eckelmann@gmx.de">sven.eckelmann@gmx.de</a>&gt;<br>
CC: Antoine van Gelder &lt;<a href="mailto:antoine@7degrees.co.za">antoine@7degrees.co.za</a>&gt;<br>
---<br>
&nbsp;vis-advanced/vis.c | &nbsp; &nbsp;2 +-<br>
&nbsp;vis-advanced/vis.h | &nbsp; &nbsp;2 ++<br>
&nbsp;vis/vis.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp;2 +-<br>
&nbsp;vis/vis.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp;2 ++<br>
&nbsp;4 files changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/vis-advanced/vis.c b/vis-advanced/vis.c<br>
index 721d690..69f69b8 100644<br>
--- a/vis-advanced/vis.c<br>
+++ b/vis-advanced/vis.c<br>
@@ -23,10 +23,10 @@<br>
<br>
<br>
&nbsp;#include &lt;fcntl.h&gt;<br>
+#include &lt;sys/socket.h&gt;<br>
&nbsp;#include &lt;net/if.h&gt;<br>
&nbsp;#include &lt;sys/ioctl.h&gt;<br>
&nbsp;#include &lt;sys/select.h&gt;<br>
-#include &lt;sys/time.h&gt;<br>
&nbsp;#include &lt;unistd.h&gt;<br>
&nbsp;#include &lt;stdlib.h&gt;<br>
&nbsp;#include &lt;stdio.h&gt;<br>
diff --git a/vis-advanced/vis.h b/vis-advanced/vis.h<br>
index 6f6793e..a060c83 100644<br>
--- a/vis-advanced/vis.h<br>
+++ b/vis-advanced/vis.h<br>
@@ -25,6 +25,8 @@<br>
&nbsp;#include &lt;pthread.h&gt;<br>
&nbsp;#include &lt;sys/socket.h&gt;<br>
&nbsp;#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/time.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
&nbsp;#include &lt;arpa/inet.h&gt;<br>
&nbsp;#include &lt;errno.h&gt;<br>
<br>
diff --git a/vis/vis.c b/vis/vis.c<br>
index 05f4096..c488365 100644<br>
--- a/vis/vis.c<br>
+++ b/vis/vis.c<br>
@@ -23,10 +23,10 @@<br>
<br>
<br>
&nbsp;#include &lt;fcntl.h&gt;<br>
+#include &lt;sys/socket.h&gt;<br>
&nbsp;#include &lt;net/if.h&gt;<br>
&nbsp;#include &lt;sys/ioctl.h&gt;<br>
&nbsp;#include &lt;sys/select.h&gt;<br>
-#include &lt;sys/time.h&gt;<br>
&nbsp;#include &lt;unistd.h&gt;<br>
&nbsp;#include &lt;stdlib.h&gt;<br>
&nbsp;#include &lt;stdio.h&gt;<br>
diff --git a/vis/vis.h b/vis/vis.h<br>
index 8953b70..1f343d8 100644<br>
--- a/vis/vis.h<br>
+++ b/vis/vis.h<br>
@@ -25,7 +25,9 @@<br>
&nbsp;#include &lt;pthread.h&gt;<br>
&nbsp;#include &lt;sys/socket.h&gt;<br>
&nbsp;#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/time.h&gt;<br>
&nbsp;#include &lt;arpa/inet.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
&nbsp;#include &lt;errno.h&gt;<br>
<font color="#888888"><br>
<br>
--<br>
1.6.0.6<br>
<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</font></blockquote></div><br>

------=_Part_54103_12323306.1231873232948--
