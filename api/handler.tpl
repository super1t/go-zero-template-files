package {{.PkgName}}

import (
	"net/http"
	{{.ImportPackages}}
	"github.com/zeromicro/go-zero/rest/httpx"
	"github.com/zeromicro/x/errors"
)

func {{.HandlerName}}(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		{{if .HasRequest}}var req types.{{.RequestType}}
		if err := httpx.Parse(r, &req); err != nil {
			httpx.Error(w, errors.New(400, err.Error()))
			return
		}

		{{end}}l := {{.LogicName}}.New{{.LogicType}}(r.Context(), svcCtx)
        {{if .HasResp}}resp, {{end}}codeMsg := l.{{.Call}}({{if .HasRequest}}&req{{end}})
        if codeMsg != nil {
        	httpx.Error(w, errors.New(codeMsg.Code, codeMsg.Msg))
        } else {
       	    {{if .HasResp}}httpx.OkJson(w, struct {
                           				Code int         `json:"code"`
                           				Msg  string      `json:"msg"`
                           				Data interface{} `json:"data,omitempty"`
                           			}{
                           				Msg: "ok",
                           				Data: resp,
                           			}){{else}}httpx.Ok(w){{end}}
        }
	}
}
