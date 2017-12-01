Return-Path: <julia.lawall@lip6.fr>
Date: Fri, 1 Dec 2017 18:01:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
In-Reply-To: <CAGXu5jKVo_8s+eBGMqBJ7Z-UpaU5aqpXFiP62ebhyV6EaoN5QA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1712011750280.2865@hadrien>
References: <20171201104756.4476-1-sven@narfation.org>
 <20171201104756.4476-2-sven@narfation.org>
 <CAGXu5jKVo_8s+eBGMqBJ7Z-UpaU5aqpXFiP62ebhyV6EaoN5QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-803520187-1512147665=:2865"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix kernel-doc for timer
 functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

--8323329-803520187-1512147665=:2865
Content-Type: text/plain; charset=US-ASCII



On Fri, 1 Dec 2017, Kees Cook wrote:

> On Fri, Dec 1, 2017 at 2:47 AM, Sven Eckelmann <sven@narfation.org> wrote:
> > The commit e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
> > changed the argument name and type of the timer function but didn't adjust
> > the kernel-doc of these functions.
> >
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > Cc: Kees Cook <keescook@chromium.org>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I wonder if there is a way for Coccinelle to change kernel-doc?

It can't change it, but with some cleverness (ie python/ocaml code) it can
be used to find problems.  I've attached a semantic patch that I wrote for
this.  It gives reports like:

drivers/acpi/arm64/iort.c:864 dma_size doesn't appear in ids: dev dma_addr size

Indeed the code has:

/**
 * iort_dma_setup() - Set-up device DMA parameters.
 *
 * @dev: device to configure
 * @dma_addr: device DMA address result pointer
 * @size: DMA range size result pointer
 */
void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)

So the kerneldoc has the wrong name.  There are also things like this:

drivers/acpi/acpica/utdebug.c:617 acpi_trace_point doesn't match preceding
comment: begin

Here the code is:

/******************************************************************************\
*
 *
 * FUNCTION:    acpi_trace_point
 *
 * PARAMETERS:  type                - Trace event type
 *              begin               - TRUE if before execution
 *              aml                 - Executed AML address
 *              pathname            - Object path
 *              pointer             - Pointer to the related object
 *
 * RETURN:      None
 *
 * DESCRIPTION: Interpreter execution trace.
 *

******************************************************************************\
/

void
acpi_trace_point(acpi_trace_event_type type, u8 begin, u8 *aml, char *pathname)

So the rule doesn't seem to know about this kind of documentation.

julia

>
> -Kees
>
> > ---
> >  net/batman-adv/tp_meter.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> > index 15cd213..ebc4e22 100644
> > --- a/net/batman-adv/tp_meter.c
> > +++ b/net/batman-adv/tp_meter.c
> > @@ -482,7 +482,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
> >
> >  /**
> >   * batadv_tp_sender_timeout - timer that fires in case of packet loss
> > - * @arg: address of the related tp_vars
> > + * @t: address to timer_list inside tp_vars
> >   *
> >   * If fired it means that there was packet loss.
> >   * Switch to Slow Start, set the ss_threshold to half of the current cwnd and
> > @@ -1106,7 +1106,7 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
> >  /**
> >   * batadv_tp_receiver_shutdown - stop a tp meter receiver when timeout is
> >   *  reached without received ack
> > - * @arg: address of the related tp_vars
> > + * @t: address to timer_list inside tp_vars
> >   */
> >  static void batadv_tp_receiver_shutdown(struct timer_list *t)
> >  {
> > --
> > 2.11.0
> >
>
>
>
> --
> Kees Cook
> Pixel Security
>
--8323329-803520187-1512147665=:2865
Content-Type: text/plain; charset=US-ASCII; name=checkdoc.cocci
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.20.1712011801050.2865@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=checkdoc.cocci

QGluaXRpYWxpemU6b2NhbWxADQpAQA0KDQpsZXQgdGJsID0gcmVmIFtdDQps
ZXQgZm5zdGFydCA9IHJlZiBbXQ0KbGV0IHN1Y2Nlc3MgPSBIYXNodGJsLmNy
ZWF0ZSAxMDENCmxldCB0aGVmaWxlID0gcmVmICIiDQpsZXQgcGFyc2VkID0g
cmVmIFtdDQpsZXQgbmVhID0gcmVmIFtdDQoNCmxldCBwYXJzZSBmaWxlID0N
CiAgdGhlZmlsZSA6PSBMaXN0Lm50aCAoU3RyLnNwbGl0IChTdHIucmVnZXhw
ICJsaW51eC1uZXh0LyIpIGZpbGUpIDE7DQogIGxldCBpID0gb3Blbl9pbiBm
aWxlIGluDQogIGxldCBzdGFydGxpbmUgPSByZWYgMCBpbg0KICBsZXQgZm4g
PSByZWYgIiIgaW4NCiAgbGV0IGlkcyA9IHJlZiBbXSBpbg0KICBsZXQgcmVj
IGluc2lkZSBuID0NCiAgICBsZXQgbCA9IGlucHV0X2xpbmUgaSBpbg0KICAg
IGxldCBuID0gbiArIDEgaW4NCiAgICBtYXRjaCBTdHIuc3BsaXRfZGVsaW0g
KFN0ci5yZWdleHBfc3RyaW5nICIqLyIpIGwgd2l0aA0KICAgICAgYmVmb3Jl
OjphZnRlcjo6XyAtPg0KCShpZiBub3QgKCFmbiA9ICIiKQ0KCXRoZW4gdGJs
IDo9ICghc3RhcnRsaW5lLG4sIWZuLExpc3QucmV2ICFpZHMpOjohdGJsKTsN
CglzdGFydGxpbmUgOj0gMDsNCglmbiA6PSAiIjsNCglpZHMgOj0gW107DQoJ
b3V0c2lkZSBuDQogICAgfCBfIC0+DQoJKG1hdGNoIFN0ci5zcGxpdCAoU3Ry
LnJlZ2V4cCAiWyBcdF0rIikgbCB3aXRoDQoJICAiKiI6Om5hbWU6OnJlc3Qg
LT4NCgkgICAgbGV0IGxlbiA9IFN0cmluZy5sZW5ndGggbmFtZSBpbg0KCSAg
ICAoaWYgIWZuID0gIiIgJiYgbGVuID4gMiAmJiBTdHJpbmcuc3ViIG5hbWUg
KGxlbi0yKSAyID0gIigpIg0KCSAgICB0aGVuIGZuIDo9IFN0cmluZy5zdWIg
bmFtZSAwIChsZW4tMikNCgkgICAgZWxzZSBpZiAhZm4gPSAiIiAmJiAobm90
IChyZXN0ID0gW10pKSAmJiBMaXN0LmhkIHJlc3QgPSAiLSINCgkgICAgdGhl
bg0KCSAgICAgIGlmIFN0cmluZy5nZXQgbmFtZSAobGVuLTEpID0gJzonDQoJ
ICAgICAgdGhlbiBmbiA6PSBTdHJpbmcuc3ViIG5hbWUgMCAobGVuLTEpDQoJ
ICAgICAgZWxzZSBmbiA6PSBuYW1lDQoJICAgIGVsc2UgaWYgbm90KCFmbiA9
ICIiKSAmJiBsZW4gPiAyICYmDQoJICAgICAgU3RyaW5nLmdldCBuYW1lIDAg
PSAnQCcgJiYgU3RyaW5nLmdldCBuYW1lIChsZW4tMSkgPSAnOicNCgkgICAg
dGhlbiBpZHMgOj0gKFN0cmluZy5zdWIgbmFtZSAxIChsZW4tMikpIDo6ICFp
ZHMpOw0KCXwgXyAtPiAoKSk7DQoJaW5zaWRlIG4NCiAgYW5kIG91dHNpZGUg
biA9DQogICAgbGV0IGwgPSBpbnB1dF9saW5lIGkgaW4NCiAgICBsZXQgbiA9
IG4gKyAxIGluDQogICAgaWYgU3RyaW5nLmxlbmd0aCBsID4gMiAmJiBTdHJp
bmcuc3ViIGwgMCAzID0gIi8qKiINCiAgICB0aGVuDQogICAgICBiZWdpbg0K
CXN0YXJ0bGluZSA6PSBuOw0KCWluc2lkZSBuDQogICAgICBlbmQNCiAgICBl
bHNlIG91dHNpZGUgbiBpbg0KICB0cnkgb3V0c2lkZSAwIHdpdGggRW5kX29m
X2ZpbGUgLT4gKCkNCg0KbGV0IGhhc2hhZGQgdGJsIGsgdiA9DQogIGxldCBj
ZWxsID0NCiAgICB0cnkgSGFzaHRibC5maW5kIHRibCBrDQogICAgd2l0aCBO
b3RfZm91bmQgLT4NCiAgICAgIGxldCBjZWxsID0gcmVmIFtdIGluDQogICAg
ICBIYXNodGJsLmFkZCB0YmwgayBjZWxsOw0KICAgICAgY2VsbCBpbg0KICBj
ZWxsIDo9IHYgOjogIWNlbGwNCg0KQHNjcmlwdDpvY2FtbEANCkBADQoNCnRi
bCA6PSBbXTsNCmZuc3RhcnQgOj0gW107DQpIYXNodGJsLmNsZWFyIHN1Y2Nl
c3M7DQpwYXJzZWQgOj0gW107DQpuZWEgOj0gW107DQpwYXJzZSAoTGlzdC5o
ZCAoQ29jY2lsaWIuZmlsZXMoKSkpDQoNCkByQA0KaWRlbnRpZmllciBmOw0K
cG9zaXRpb24gcDsNCkBADQoNCmZAcCguLi4pIHsgLi4uIH0NCg0KQHNjcmlw
dDpvY2FtbEANCnAgPDwgci5wOw0KZiA8PCByLmY7DQpAQA0KDQpwYXJzZWQg
Oj0gZiA6OiAhcGFyc2VkOw0KZm5zdGFydCA6PSAoTGlzdC5oZCBwKS5saW5l
IDo6ICFmbnN0YXJ0DQoNCkBwYXJhbUANCmlkZW50aWZpZXIgZjsNCnR5cGUg
VDsNCmlkZW50aWZpZXIgaTsNCnBhcmFtZXRlciBsaXN0W25dIHBzOw0KcGFy
YW1ldGVyIGxpc3RbbjFdIHBzMTsNCnBvc2l0aW9uIHA7DQpAQA0KDQpmQHAo
cHMsVCBpLHBzMSkgeyAuLi4gfQ0KDQpAc2NyaXB0Om9jYW1sQA0KQEANCg0K
dGJsIDo9IExpc3QucmV2IChMaXN0LnNvcnQgY29tcGFyZSAhdGJsKQ0KDQpA
c2NyaXB0Om9jYW1sQA0KcCA8PCBwYXJhbS5wOw0KZiA8PCBwYXJhbS5mOw0K
QEANCg0KbGV0IG15bGluZSA9IChMaXN0LmhkIHApLmxpbmUgaW4NCmxldCBw
cmV2bGluZSA9DQogIExpc3QuZm9sZF9sZWZ0DQogICAgKGZ1biBwcmV2IHgg
LT4NCiAgICAgIGlmIHggPCBteWxpbmUNCiAgICAgIHRoZW4gbWF4IHggcHJl
dg0KICAgICAgZWxzZSBwcmV2KQ0KICAgIDAgIWZuc3RhcnQgaW4NCmxldCBf
ID0NCiAgTGlzdC5leGlzdHMNCiAgICAoZnVuY3Rpb24gKHN0LGZuLG5tLGlk
cykgLT4NCiAgICAgIGlmIHByZXZsaW5lIDwgc3QgJiYgbXlsaW5lID4gc3Qg
JiYgcHJldmxpbmUgPCBmbiAmJiBteWxpbmUgPiBmbg0KICAgICAgdGhlbg0K
CWJlZ2luDQoJICAoaWYgbm90IChTdHJpbmcubG93ZXJjYXNlIGYgPSBTdHJp
bmcubG93ZXJjYXNlIG5tKQ0KCSAgdGhlbg0KCSAgICBQcmludGYucHJpbnRm
ICIlczolZCAlcyBkb2Vzbid0IG1hdGNoIHByZWNlZGluZyBjb21tZW50OiAl
c1xuIg0KCSAgICAgICF0aGVmaWxlIG15bGluZSBmIG5tKTsNCgkgIHRydWUN
CgllbmQNCiAgICAgIGVsc2UgZmFsc2UpDQogICAgIXRibCBpbg0KKCkNCg0K
QHNjcmlwdDpvY2FtbEANCnAgPDwgcGFyYW0ucDsNCm4gPDwgcGFyYW0ubjsN
Cm4xIDw8IHBhcmFtLm4xOw0KaSA8PCBwYXJhbS5pOw0KZiA8PCBwYXJhbS5m
Ow0KQEANCg0KbGV0IG15bGluZSA9IChMaXN0LmhkIHApLmxpbmUgaW4NCmxl
dCBwcmV2bGluZSA9DQogIExpc3QuZm9sZF9sZWZ0DQogICAgKGZ1biBwcmV2
IHggLT4NCiAgICAgIGlmIHggPCBteWxpbmUNCiAgICAgIHRoZW4gbWF4IHgg
cHJldg0KICAgICAgZWxzZSBwcmV2KQ0KICAgIDAgIWZuc3RhcnQgaW4NCmxl
dCBfID0NCiAgTGlzdC5leGlzdHMNCiAgICAoZnVuY3Rpb24gKHN0LGZuLG5t
LGlkcykgLT4NCiAgICAgIGlmIHByZXZsaW5lIDwgc3QgJiYgbXlsaW5lID4g
c3QgJiYgcHJldmxpbmUgPCBmbiAmJiBteWxpbmUgPiBmbg0KICAgICAgdGhl
bg0KCWJlZ2luDQoJICAoaWYgTGlzdC5tZW0gaSBpZHMgdGhlbiBoYXNoYWRk
IHN1Y2Nlc3MgKHN0LGZuLG5tKSBpKTsNCgkgIChpZiBpZHMgPSBbXSAoKiBh
cmcgbGlzdCBzZWVtcyBub3Qgb2JsaWdhdG9yeSAqKQ0KCSAgdGhlbiAoKQ0K
CSAgZWxzZSBpZiBub3QgKExpc3QubWVtIGkgaWRzKQ0KCSAgdGhlbg0KCSAg
ICBQcmludGYucHJpbnRmICIlczolZCAlcyBkb2Vzbid0IGFwcGVhciBpbiBp
ZHM6ICVzXG4iDQoJICAgICAgIXRoZWZpbGUgbXlsaW5lIGkgKFN0cmluZy5j
b25jYXQgIiAiIGlkcykNCgkgIGVsc2UgaWYgTGlzdC5sZW5ndGggaWRzIDw9
IG4gfHwgTGlzdC5sZW5ndGggaWRzIDw9IG4xDQoJICB0aGVuDQoJICAgIChp
ZiBub3QgKExpc3QubWVtIGYgIW5lYSkNCgkgICAgdGhlbg0KCSAgICAgIGJl
Z2luDQoJCW5lYSA6PSBmIDo6ICFuZWE7DQoJCVByaW50Zi5wcmludGYgIiVz
OiVkICVzIG5vdCBlbm91Z2ggYXJnc1xuIiAhdGhlZmlsZSBteWxpbmUgZjsN
CgkgICAgICBlbmQpDQoJICBlbHNlDQoJICAgIGxldCBmb3VuZGlkID0gTGlz
dC5udGggaWRzIG4gaW4NCgkgICAgbGV0IGVmb3VuZGlkID0gTGlzdC5udGgg
KExpc3QucmV2IGlkcykgbjEgaW4NCgkgICAgaWYgbm90KGZvdW5kaWQgPSBp
IHx8IGVmb3VuZGlkID0gaSkNCgkgICAgdGhlbg0KCSAgICAgIFByaW50Zi5w
cmludGYgIiVzOiVkICVzIHdyb25nIGFyZyBpbiBwb3NpdGlvbiAlZDogJXNc
biINCgkJIXRoZWZpbGUgbXlsaW5lIGkgbiBmb3VuZGlkKTsNCgkgIHRydWUN
CgllbmQNCiAgICAgIGVsc2UgZmFsc2UpDQogICAgIXRibCBpbg0KKCkNCg0K
QHNjcmlwdDpvY2FtbEANCkBADQpMaXN0Lml0ZXINCiAgKGZ1bmN0aW9uIChz
dCxmbixubSxpZHMpIC0+DQogICAgaWYgTGlzdC5tZW0gbm0gIXBhcnNlZA0K
ICAgIHRoZW4NCiAgICAgIGxldCBlbnRyeSA9DQoJdHJ5ICEoSGFzaHRibC5m
aW5kIHN1Y2Nlc3MgKHN0LGZuLG5tKSkNCgl3aXRoIE5vdF9mb3VuZCAtPiBb
XSBpbg0KICAgICAgTGlzdC5pdGVyDQoJKGZ1biBpZCAtPg0KCSAgaWYgbm90
IChMaXN0Lm1lbSBpZCBlbnRyeSkgJiYgbm90IChpZCA9ICIuLi4iKQ0KCSAg
dGhlbiBQcmludGYucHJpbnRmICIlczolZCAlcyBub3QgdXNlZFxuIiAhdGhl
ZmlsZSBzdCBpZCkNCglpZHMpDQogICF0YmwNCg==

--8323329-803520187-1512147665=:2865--
